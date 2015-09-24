class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  validates_numericality_of :participants, greater_than: 0, message: "must be greater than 0"
  validates_numericality_of :active_participants, greater_than_or_equal_to: 0
  validates_inclusion_of :category, in: ['Sports', 'Culture', 'Coding', 'Education', 'Music', 'Comedy', 'Nightlife'], message: "Must choose category"
  validates_presence_of :location, :participants, :category, :tag, :title, :time
  validates_presence_of :date, on: :create

  def has_spaces?
    self.active_participants < self.participants
  end

  def build_rating(params, user)
    rating = ratings.build(value: params[:value], user_id: user.id)
  end

end
