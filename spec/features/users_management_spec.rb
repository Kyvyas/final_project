require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Name', with: 'Harry')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  scenario 'activity host has profile' do
    user = create(:user)
    sign_in_as(user)
    activity = build(:activity)
    create_activity(activity)
    click_on('Football')
    click_on('Katya')
    expect(page).to have_content("Katya")
  end

  context 'user profile' do
    scenario "has hosted activities" do
      user = create(:user)
      sign_in_as(user)
      activity = build(:activity)
      create_activity(activity)
      click_on('Football')
      click_on('Katya')
      expect(page).to have_content("Hosted activities: Football")
    end
    scenario "has attended activities", js: true do
      user = create(:user)
      sign_in_as(user)
      activity = build(:activity)
      create_activity(activity)
      click_on("Sign out")
      user2 = create(:user_2)
      sign_in_as(user2)
      activity2 = build(:activity2)
      create_activity(activity2)
      visit '/'
      click_on('Football')
      click_on("I'm in")
      visit '/'
      click_on('Tennis')
      click_on('Harry')
      expect(page).to have_content("Attended activities: Football")
    end
  end
end
