class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :attendances
  has_many :ratings
  has_many :attended_activities, through: :attendances, source: :activity

  has_many :activities
  validates_presence_of :name
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/pirate-icon.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     # user.name = auth.info.name   # assuming the user model has a name
     # user.image = auth.info.image # assuming the user model has an image
   end
  end


  def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
   end
  end

  def has_clicked?(activity)
    activity.attendees.include?(self)
  end

end
