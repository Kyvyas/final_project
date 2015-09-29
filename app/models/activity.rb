  class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :attendances
  has_many :ratings
  has_many :attendees, through: :attendances, source: :user
  before_create :check_params

  validates_numericality_of :participants, greater_than: 0, message: "must be greater than 0"
  validates_numericality_of :active_participants, greater_than_or_equal_to: 0
  validates_inclusion_of :category, in: ['Sports', 'Culture', 'Coding', 'Education', 'Music', 'Comedy', 'Nightlife'], message: "Must choose category"
  validates_presence_of :location, :participants, :category, :tag, :title
  validates_presence_of :datetime, on: :create
  validate :date_cannot_be_in_past

  geocoded_by :location
  after_validation :geocode

  def has_spaces?
    self.active_participants < self.participants
  end

  def check_params
    self.tag.downcase!
  end


  def date_cannot_be_in_past
    errors.add(:datetime, "Your activity cannot be in the past! Leave the past where it is...") if
      !datetime.blank? and datetime < Date.today
  end

  def build_rating(params, user)
    rating = ratings.build(value: params[:value], user_id: user.id)
  end

  def has_happened?
    self.datetime < DateTime.now
  end

end
