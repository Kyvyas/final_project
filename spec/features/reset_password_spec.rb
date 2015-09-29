describe 'Reset password' do

  xit 'resets password with a valid token', js: true do
    user = create(:user)
    user.reset_password_token = "jWzK25Cai6n6q64FyXAy"
    user.save

    visit "/users/password/edit?reset_password_token=#{user.reset_password_token}"
    fill_in 'user[password]', with: 'newpassword1234'
    fill_in 'user[password_confirmation]', with: 'newpassword1234'
    click_button "Change my password"
    expect { click_button "Change my password" }.to change(user, :encrypted_password)
  end

end