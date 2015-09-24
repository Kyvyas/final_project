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

  scenario 'user can rate activity they have signed up for' do
    visit '/'
    click_on 'Football'
    click_on "I'm in!"
    expect(page).to have_content "Rate activity"
    click_on("Rate activity")
    choose("rating_value_3")
    click_on("Rate activity")
    expect(page).to have_content "Activity Rating: 3"
  end

end