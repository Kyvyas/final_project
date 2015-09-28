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

  scenario 'user can rate activity they have signed up for', js: true do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    click_on "My Profile"
    click_on "Football"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content "Activity Rating: ★★★☆☆"
  end

  scenario 'user does not see rate activity link if they have already rated', js: true do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    click_on "My Profile"
    click_on "Football"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content "Activity Rating: ★★★☆☆"
    expect(page).not_to have_content "Rate activity"
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
  end

end