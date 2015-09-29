class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.activities.any?
      @host_rating = @user.host_rating
      @future_hosted_activities = @user.activities.where(['datetime >= ?', DateTime.now])
      @past_hosted_activities = @user.activities.where(['datetime < ?', DateTime.now])
    end
  end
end
