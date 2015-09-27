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

    it "can sign up with a photo" do
      visit('/')
      click_link('Sign up')
      fill_in('Name', with: 'Harry')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      allow_any_instance_of(Paperclip::Attachment).to receive(:url).and_return("/spec/asset_specs/photos/Pirate-Parrot.jpg")
      click_button('Sign up')
      click_on "My Profile"
      expect(page).to have_css('img[src*="Pirate-Parrot.jpg"]')
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
    scenario 'user can visit own profile' do
      user = create(:user)
      sign_in_as(user)
      visit '/'
      click_on 'My Profile'
      expect(page).to have_content("Katya")
    end

    scenario "has hosted activities" do
      user = create(:user)
      sign_in_as(user)
      activity = build(:activity)
      create_activity(activity)
      click_on('Football')
      click_on('Katya')
      expect(page).to have_content("Hosted activities: Football")
      expect(page).not_to have_content("No hosted activities yet!")
    end

    scenario "has no hosted activities if none exist" do
      user = create(:user)
      sign_in_as(user)
      click_on("My Profile")
      expect(page).to have_content("No hosted activities yet!")
    end

    scenario "shows average activity rating for hosted activities", js: true do
      user = create(:user)
      sign_in_as(user)
      activity = build(:activity)
      create_activity(activity)
      click_on("Sign out")
      user2 = create(:user_2)
      sign_in_as(user2)
      click_on('Football')
      click_on("I'm in")
      click_on("My Profile")
      click_on("Football")
      click_on("Rate activity")
      choose("rating_value_3")
      click_on("Rate activity")
      click_on('Katya')
      expect(page).to have_content("Activity Rating: ★★★☆☆")
    end

    scenario "shows average host rating", js: true do
      user = create(:user)
      sign_in_as(user)
      activity = build(:activity)
      create_activity(activity)
      activity2 = build(:activity2)
      create_activity(activity2)
      click_on("Sign out")
      user2 = create(:user_2)
      sign_in_as(user2)
      visit'/'
      click_on('Football')
      click_on("I'm in")
      click_on("My Profile")
      click_on("Football")
      click_on("Rate activity")
      choose("rating_value_5")
      click_on("Rate activity")
      visit '/'
      click_on("Tennis")
      click_on("I'm in")
      click_on("My Profile")
      click_on("Tennis")
      click_on("Rate activity")
      choose("rating_value_1")
      click_on("Rate activity")
      click_on('Katya')
      expect(page).to have_content("Host Rating: ★★★☆☆")
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
      click_on "My Profile"
      expect(page).to have_content("Attended activities: Football")
    end

    scenario "has no attended activities if none exist" do
      user = create(:user)
      sign_in_as(user)
      click_on("My Profile")
      expect(page).to have_content("No attended activities yet!")
    end
  end
end
