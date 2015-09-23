class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  def has_spaces?
    self.active_participants < self.participants
  end
end
