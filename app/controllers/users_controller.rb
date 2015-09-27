class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.activities.any?
      @host_rating = @user.host_rating
    end
  end
end
