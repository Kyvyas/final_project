class AttendancesController < ApplicationController
  def new
    @activity = Activity.find(params[:activity_id])
    @attendance = Attendance.new
    @activity.update(active_participants: @activity.active_participants + 1)
    redirect_to :back
    flash[:notice] = "You're in!"
  end
end