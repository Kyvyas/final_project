module FeatureHelpers

  def sign_up_as(user)
    visit '/'
    click_link 'Sign up'
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  def sign_in_as(user)
    visit '/'
    click_link 'Sign in'
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Log in'
  end

  def create_activity(activity)
    visit '/'
    click_link 'Add an activity'
    fill_in "Activity Name", with: activity.title
    fill_in "Describe your Activity", with: activity.description
    fill_in "Location", with: activity.location
    fill_in "People needed", with: activity.participants
    fill_in "Date", with: activity.date
    fill_in "Time", with: activity.time
    select activity.category, from: "Category"
    fill_in "Activity e.g.'Football'", with: activity.tag
    click_on "Let's do it"
  end

end