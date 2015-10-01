require 'rails_helper'

feature 'rating' do
  before(:each) do
    user = create(:user)
    sign_in_as(user)
    activity = build(:activity)
    create_activity(activity)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
  end

  scenario 'user cannot rate activity they have not signed up for' do
    visit '/'
    click_on 'Football'
    expect(page).not_to have_content "Rate activity"
  end

  scenario 'user can rate activity they have signed up for after it has begun', js: true do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    t = Time.local(2016, 10, 7, 12, 0, 0)
    Timecop.travel(t)
    click_on "My Profile"
    click_on "Football"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content "Activity Rating: ★★★☆☆"
    Timecop.return
  end

  scenario 'user does not see rate activity link if they have already rated', js: true do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    Timecop.freeze(Time.local(2016, 10, 7, 12, 0, 0))
    click_on "My Profile"
    click_on "Football"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content "Activity Rating: ★★★☆☆"
    expect(page).not_to have_content "Rate activity"
    Timecop.return
  end

  scenario "user does not see I'm in link if they are host", js: true do
    activity2 = build(:activity2)
    create_activity(activity2)
    visit '/'
    click_on 'Tennis'
    expect(page).not_to have_content("I'm in!")
  end

  scenario 'user cannot rate activity more than once', js: true do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    t = Time.local(2016, 10, 7, 12, 0, 0)
    Timecop.travel(t)
    click_on "My Profile"
    click_on "Football"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    visit "/activities/1/ratings/new"
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content("Activity already rated.")
    Timecop.return
  end

    describe "time mock testing on rating" do
      # before do
      #   Timecop.freeze(Time.local(2016, 10, 5, 12, 0, 0))
      # end

      # after do
      #   Timecop.return
      # end

      scenario 'user cannot rate activity until after it has happened', js: true do
        visit '/'
        click_on 'Football'
        click_on "I'm in!"
        click_on "My Profile"
        click_on "Football"
        expect(page).not_to have_content "Rate activity"
        expect(page).to have_content "You can rate this only after the event!"
      end

      scenario 'user can rate activity until after it has happened', js: true do
        visit '/'
        click_on 'Football'
        click_on "I'm in!"
        Timecop.freeze(Time.local(2016, 10, 7, 12, 0, 0))
        click_on "My Profile"
        click_on "Football"
        expect(page).to have_content "Rate activity"
        expect(page).not_to have_content "You can rate this only after the event!"
        Timecop.return
      end

    end

end