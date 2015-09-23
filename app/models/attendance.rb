class Attendance < ActiveRecord::Base

  belongs_to :user
  belongs_to :activity

  validates :user, uniqueness: { scope: :activity, message: "has already been taken" }

end
