class ConfirmationMailer < ApplicationMailer

  def confirm_activity(activity, user)
    @user = user
    @activity = activity
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Your activity has been created')
  end

  def confirm_attendance(activity, user)
    @user = user
    @activity = activity
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'You have signed up for an activity')
  end

  def notify_of_attendance(activity, user, attendee)
    @user = user
    @activity = activity
    @attendee = attendee
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Someone is coming to your party!')
  end


end
