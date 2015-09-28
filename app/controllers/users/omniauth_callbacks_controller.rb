class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.save
    p '++++++'
    p @user
    p"=========="
    if @user.persisted?
      p "user has been persisted"
      p @user
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      p "======user errors:"
      p @user.errors.to_a
      p "======auth stuff"
      p request.env["omniauth.auth"]
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
