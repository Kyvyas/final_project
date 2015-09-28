class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  validates_uniqueness_of :activity, scope: :user, message: "already rated."
end
