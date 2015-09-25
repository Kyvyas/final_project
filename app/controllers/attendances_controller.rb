class AttendancesController < ApplicationController
  def new
    @activity = Activity.find(params[:activity_id])
    @attendance = Attendance.new(user_id: current_user.id, activity_id: @activity.id)
    if @activity.has_spaces?
      if @attendance.save
        @activity.update(active_participants: @activity.active_participants + 1)
        flash[:notice] = "You're in!"
        redirect_to :back
      else
        flash[:notice] = "You've already signed up to this - awesome!"
        redirect_to :back
      end
    else
      flash[:notice] = "Sorry, this activity is full"
      redirect_to '/'
    end
  end
end
