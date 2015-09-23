class AttendancesController < ApplicationController
  def new
    @activity = Activity.find(params[:activity_id])
    if @activity.has_spaces?
      @attendance = Attendance.new
      @activity.update(active_participants: @activity.active_participants + 1)
      flash[:notice] = "You're in!"
    else
      flash[:notice] = "Sorry, this activity is full"
    end
    redirect_to :back
  end
end