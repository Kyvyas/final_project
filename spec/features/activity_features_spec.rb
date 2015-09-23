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
    fill_in "Date", with: "06/10/2016"
    fill_in "Time", with: "18:00"
    select "Sport", from: "Category"
    fill_in "Activity e.g.'Football'", with: "Football"
    click_on("Let's do it")
    expect(page).to have_content("Your activity has been posted! Good luck!")
    expect(page).to have_content("Football")
  end

  scenario 'user can participate in an activity' do
    visit '/'
    activity = create(:activity)
    click_on("Sign out")
    user2 = create(:user_2)
    sign_in_as(user2)
    click_on('Football')
    expect(page).to have_content("People needed: 6")
    click_on("I'm in!")
    expect(page).to have_content("People needed: 5")
  end

end