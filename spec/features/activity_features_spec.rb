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

  scenario 'user creates a new activity' do
    visit '/'
    click_link("Add an activity")
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
    expect(page).to have_content("Your activity has been posted! Good luck!")
    expect(page).to have_content("Football")
  end

  scenario 'host is visible on the activity page' do
    activity = build(:activity)
    create_activity(activity)
    visit '/'
    click_on('Football')
    expect(page).to have_content("Hosted by: Katya")
  end

  scenario 'user can sign up to an activity', js: true do
    visit '/'
    activity = build(:activity)
    create_activity(activity)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
    click_on('Football')
    expect(page).to have_content("People needed: 6")
    click_on("I'm in!")
    sleep 1
    expect(page).to have_content("People needed: 5")
  end

  scenario 'user cannot make an activity without a title' do
    visit '/'
    activity = build(:activity, title: "")
    create_activity(activity)
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'user cannot make an activity without a location' do
    visit '/'
    activity = build(:activity, location: "")
    create_activity(activity)
    expect(page).to have_content("Location can't be blank")
  end

  scenario 'user cannot make an activity without a category' do
    visit '/'
    activity = build(:activity, category: "Select")
    create_activity(activity)
    expect(page).to have_content("Must choose category")
  end

  scenario 'user cannot make an activity without a tag' do
    visit '/'
    activity = build(:activity, tag: "")
    create_activity(activity)
    expect(page).to have_content("Tag can't be blank")
  end

  scenario "user does not see the 'I'm in' button if the activity is full", js: true do
    visit '/'
    activity1 = build(:activity1)
    create_activity(activity1)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
    click_on('Tennis')
    click_on("I'm in!")
    click_on('Sign out')
    user3 = create(:user_3)
    sign_in_as(user3)
    click_on("Tennis")
    expect(page).not_to have_content("I'm in")
  end

  scenario "users does not see the 'I'm in' button if they are attending the activity", js: true do
    visit '/'
    activity = build(:activity)
    create_activity(activity)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
    click_on('Football')
    click_on("I'm in!")
    expect(page).not_to have_content("I'm in!")
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
    expect(page).to have_content("must be greater than 0")
  end


  context "activities need to be ordered by time at which they occur" do
    scenario 'activities are displayed in order ascending by time' do
      activity = build(:activity)
      create_activity(activity)
      activity2 = build(:activity2)
      create_activity(activity2)
      visit '/'
      expect(page).to have_content("Football Tennis")
    end

    scenario 'cannot be displayed in the wrong order' do
      activity2 = build(:activity2)
      create_activity(activity2)
      activity = build(:activity)
      create_activity(activity)
      visit '/'
      expect(page).to have_content("Football Tennis")
    end
  end

  scenario "user can filter activities by category" do
    activity = build(:activity)
    create_activity(activity)
    activity3 = build(:activity3)
    create_activity(activity3)
    visit '/'
    select "Sports", from: "Category"
    click_on("Filter")
    expect(page).to have_content("Football")
    expect(page).not_to have_content("Tom Jones Concert")
  end

  scenario "users can search activities by tag" do
    activity = build(:activity)
    create_activity(activity)
    activity2 = build(:activity2)
    create_activity(activity2)
    visit '/'
    fill_in "Search for a pirate activity", with: "Tennis"
    click_on "Search"
    expect(page).to have_content("Tennis")
    expect(page).not_to have_content("Football")
  end

  scenario "users can search activities by tag regardless of case" do
    activity = build(:activity)
    create_activity(activity)
    activity2 = build(:activity2)
    create_activity(activity2)
    visit '/'
    fill_in "Search for a pirate activity", with: "tenNis"
    click_on "Search"
    expect(page).to have_content("Tennis")
    expect(page).not_to have_content("Football")
  end

  scenario "users cannot create activities in the past" do
    past_activity = build(:past_activity)
    create_activity(past_activity)
    expect(page).to have_content("Your activity cannot be in the past! Leave the past where it is...")
  end

  context "Time mock testing:" do
    scenario "activity list does not list past activities - date" do
      activity = build(:activity)
      create_activity(activity)
      activity2 = build(:activity2)
      create_activity(activity2)
      t = Time.local(2016, 10, 9, 10, 5, 0)
      Timecop.travel(t)
      visit '/'
      Timecop.return
      expect(page).to have_content("Tennis")
      expect(page).not_to have_content("Football")
    end
    scenario "activity list does not list past activities - time" do
      activity = build(:activity)
      create_activity(activity)
      activity_late = build(:activity_late)
      create_activity(activity_late)
      t = Time.local(2016, 10, 6, 18, 30, 00)
      p t
      Timecop.travel(t)
      visit '/'
      Timecop.return
      expect(page).to have_content("running")
      expect(page).not_to have_content("Football")
    end
  end

end
