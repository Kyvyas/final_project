class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :attendees, through: :attendances, source: :user
end
