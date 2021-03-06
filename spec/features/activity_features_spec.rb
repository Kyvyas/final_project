require 'rails_helper'

feature 'activity' do

  before(:each) do
    user = create(:user)
    sign_in_as(user)
  end

  scenario 'user can add an activity' do
    visit '/'
    expect(page).to have_content("Add an activity")
  end

  scenario 'user creates a new activity', js: true do
    visit '/'
    find(".add-activity-large").trigger('click')
    fill_in "Activity Name", with: "Football"
    fill_in "Describe your Activity", with: "Football in the park, yea"
    fill_in "Location", with: "Regent's Park"
    fill_in "People needed", with: "6"
    select '2016', from: 'activity_datetime_1i'
    select 'October', from: 'activity_datetime_2i'
    select '6', from: 'activity_datetime_3i'
    select '18', from: 'activity_datetime_4i'
    select '00', from: 'activity_datetime_5i'
    select "Sport", from: "Category"
    fill_in "Activity e.g.'Football'", with: "Football"
    click_on("Let's do it")
    click_on("Confirm")
    expect(page).to have_content("Your activity has been posted! Good luck!")
    visit '/categories?utf8=&Category=Sports'
    expect(page).to have_content("Football")
  end

  scenario 'host is visible on the activity page' do
    activity = build(:activity)
    make_activity(activity)
    visit '/categories?utf8=&Category=Sports'
    click_on('Football')
    expect(page).to have_content("Hosted by: Katya")
  end
  context "stuff with built activity" do
    before(:each) do
      visit '/'
      activity = build(:activity)
      create_activity(activity)
      visit '/categories?utf8=&Category=Sports'
      expect(page).to have_content("Football")
    end
    scenario 'user can sign up to an activity', js: true do
      click_on("Sign out")
      user2 = create(:user_2)
      sign_in_as(user2)
      visit '/categories?utf8=&Category=Sports'
      click_on('Football')
      expect(page).to have_content("People still needed: 6")
      click_on("I'm in!")
      sleep 1
      expect(page).to have_content("People still needed: 5")
    end
  end

  scenario 'user cannot make an activity without a title' do
    visit '/'
    activity = build(:activity, title: "")
    make_activity(activity)
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'user cannot make an activity without a location' do
    visit '/'
    activity = build(:activity, location: "")
    make_activity(activity)
    expect(page).to have_content("Location can't be blank")
  end

  scenario 'user cannot make an activity without a category' do
    visit '/'
    activity = build(:activity, category: "Select")
    make_activity(activity)
    expect(page).to have_content("Must choose category")
  end

  scenario 'user cannot make an activity without a tag' do
    visit '/'
    activity = build(:activity, tag: "")
    make_activity(activity)
    expect(page).to have_content("Tag can't be blank")
  end

   scenario "user cannot add activity with negative participants" do
    visit '/'
    click_link("Add an activity")
    fill_in "Activity Name", with: "Football"
    fill_in "Describe your Activity", with: "Football in the park, yea"
    fill_in "Location", with: "Regent's Park"
    fill_in "People needed", with: "-2"
    select '2016', from: 'activity_datetime_1i'
    select 'October', from: 'activity_datetime_2i'
    select '6', from: 'activity_datetime_3i'
    select '18', from: 'activity_datetime_4i'
    select '00', from: 'activity_datetime_5i'
    select "Sport", from: "Category"
    fill_in "Activity e.g.'Football'", with: "Football"
    click_on("Let's do it")
    click_on("Confirm")
    expect(page).to have_content("must be greater than 0")
  end

  scenario "user does not see the 'I'm in' button if the activity is full", js: true do
    visit '/'
    activity1 = build(:activity1)
    create_activity(activity1)
    click_on("Sign out")
    sleep 2
    user2 = create(:user_2)
    sign_in_as(user2)
    visit '/categories?utf8=&Category=Sports'
    click_on('Tennis')
    click_on("I'm in!")
    click_on('Sign out')
    sleep 2
    user3 = create(:user_3)
    sign_in_as(user3)
    visit '/categories?utf8=&Category=Sports'
    expect(page).to have_content("Tennis")
    click_on("Tennis")
    sleep 2
    expect(page).to have_content("Tennis")
    expect(page).not_to have_content("I'm in")
  end

  scenario "users does not see the 'I'm in' button if they are attending the activity", js: true do
    visit '/'
    activity = build(:activity)
    create_activity(activity)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
    visit '/categories?utf8=&Category=Sports'
    click_on('Football')
    click_on("I'm in!")
    expect(page).not_to have_content("I'm in!")
    visit '/'
    find('.add-activity-large').trigger('click')
    fill_in "Activity Name", with: "Football"
    fill_in "Describe your Activity", with: "Football in the park, yea"
    fill_in "Location", with: "Regent's Park"
    fill_in "People needed", with: "-2"
    select '2016', from: 'activity_datetime_1i'
    select 'October', from: 'activity_datetime_2i'
    select '6', from: 'activity_datetime_3i'
    select '18', from: 'activity_datetime_4i'
    select '00', from: 'activity_datetime_5i'
    select "Sport", from: "Category"
    fill_in "Activity e.g.'Football'", with: "Football"
    click_on("Let's do it")
    click_on("Confirm")
    expect(page).to have_content("must be greater than 0")
  end


  scenario "user can filter activities by category" do
    activity = build(:activity)
    make_activity(activity)
    activity3 = build(:activity3)
    make_activity(activity3)
    visit '/'
    select "Sports", from: "Category"
    click_on("Filter")
    expect(current_path).to eq '/categories'
    expect(page).to have_content("Football")
    expect(page).not_to have_content("Tom Jones Concert")
  end

  scenario "users cannot create activities in the past" do
    past_activity = build(:past_activity)
    make_activity(past_activity)
    expect(page).to have_content("Your activity cannot be in the past! Leave the past where it is...")
  end

  context "activities need to be ordered by time at which they occur" do
    scenario 'activities are displayed in order ascending by time' do
      activity = build(:activity)
      make_activity(activity)
      activity2 = build(:activity2)
      make_activity(activity2)
      visit '/categories?utf8=&Category=Sports'
      expect(page).to have_content("Football")
      expect(page).to have_content("Tennis")
    end

    scenario 'cannot be displayed in the wrong order' do
      activity2 = build(:activity2)
      make_activity(activity2)
      activity = build(:activity)
      make_activity(activity)
      visit '/categories?utf8=&Category=Sports'
      expect(page).to have_content("Football")
      expect(page).to have_content("Tennis")
    end
  end

  context "Time mock testing:" do
    scenario "activity list does not list past activities - date" do
      activity = build(:activity)
      make_activity(activity)
      activity2 = build(:activity2)
      make_activity(activity2)
      t = Time.local(2016, 10, 9, 10, 5, 0)
      Timecop.travel(t)
      sleep 2
      visit '/categories?utf8=&Category=Sports'
      expect(page).to have_content("Tennis")
      expect(page).not_to have_content("Football")
      Timecop.return
    end
    it "activity list does not list past activities - time" do
      activity = build(:activity)
      make_activity(activity)
      activity_late = build(:activity_late)
      make_activity(activity_late)
      t = Time.local(2016, 10, 6, 18, 30, 00)
      p t
      Timecop.travel(t)
      visit '/categories?utf8=&Category=Sports'
      expect(page).to have_content("running")
      expect(page).not_to have_content("Football")
      Timecop.return
    end
  end

  scenario "user can delete their hosted activities before they happen" do
    t = Time.local(2016, 10, 6, 12, 0, 0)
    Timecop.travel(t)
    activity = build(:activity)
    make_activity(activity)
    visit '/'
    click_on 'My Profile'
    click_on "Football"
    click_on "Delete"
    expect(page).not_to have_content("Football")
    Timecop.return
  end

  scenario "user cannot delete their hosted activities after they happen" do
    t = Time.local(2117, 10, 6, 17, 0, 0)
    activity = build(:activity)
    make_activity(activity)
    Timecop.travel(t)
    visit '/'
    click_on 'My Profile'
    click_on "Football"
    expect(page).not_to have_content("Delete")
    Timecop.return
  end

  scenario 'user can delete their attendance from an activity before it happens', js: true do
    t = Time.local(2016, 10, 6, 12, 0, 0)
    Timecop.travel(t)
    activity = build(:activity)
    create_activity(activity)
    click_on 'Sign out'
    user2 = create(:user_2)
    sign_in_as(user2)
    visit '/categories?utf8=&Category=Sports'
    click_on "Football"
    click_on "I'm in"
    visit '/categories?utf8=&Category=Sports'
    click_on 'Football'
    click_on "I'm out"
    expect(page).to have_content("You are no longer attending this activity")
    Timecop.return
  end

  scenario 'user can delete their attendance which updates the number of people needed', js: true do
    t = Time.local(2016, 10, 6, 12, 0, 0)
    Timecop.travel(t)
    activity = build(:activity)
    create_activity(activity)
    click_on 'Sign out'
    user2 = create(:user_2)
    sign_in_as(user2)
    visit '/categories?utf8=&Category=Sports'
    click_on "Football"
    click_on "I'm in"
    visit '/categories?utf8=&Category=Sports'
    click_on 'Football'
    click_on "I'm out"
    visit '/categories?utf8=&Category=Sports'
    click_on "Football"
    expect(page).to have_content("People still needed: 6")
    Timecop.return
  end


end
