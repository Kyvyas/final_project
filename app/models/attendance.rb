class Attendance < ActiveRecord::Base

  belongs_to :user
  belongs_to :activity

  validates :user, uniqueness: { scope: :activity, message: "has already been taken" }
  validate :user_is_not_host

  def user_is_not_host
    if user.activities.include?(activity)
      errors.add(:user, "You are the host of this activity")
    end
  end
end
