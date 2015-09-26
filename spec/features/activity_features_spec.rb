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
    fill_in "Date", with: "06/10/2016 00:00:00"
    fill_in "Time", with: "18:00"
    select "Sport", from: "Category"
    fill_in "Activity e.g.'Football'", with: "Football"
    click_on("Let's do it")
    expect(page).to have_content("Your activity has been posted! Good luck!")
    expect(page).to have_content("Football")
  end

    scenario 'host is visible on the activity page' do
      activity = build(:activity)
      create_activity(activity)
      click_on('Football')
      expect(page).to have_content("Hosted by: ")
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

  scenario 'user cannot make an activity without a time' do
    visit '/'
    activity = build(:activity, time: "")
    create_activity(activity)
    expect(page).to have_content("Time can't be blank")
  end

  scenario 'user cannot make an activity without a date' do
    visit '/'
    activity = build(:activity, date: "")
    create_activity(activity)
    expect(page).to have_content("Date can't be blank")
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
    fill_in "Date", with: "06/10/2016"
    fill_in "Time", with: "18:00"
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

  scenario "users can search activities by tag regardless of case", js: true do
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

end
