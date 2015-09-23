class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
  validates_numericality_of :participants, greater_than: 0
  validates_numericality_of :active_participants, greater_than_or_equal_to: 0

  def has_spaces?
    self.active_participants < self.participants
  end
end
