class Attendance < ActiveRecord::Base

  belongs_to :user, :activity

end
