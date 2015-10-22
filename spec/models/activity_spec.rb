require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :ratings }
  it { is_expected.to have_many :attendances }
  it { should validate_numericality_of(:participants).is_greater_than(0).with_message(/must be greater than 0/) }
  it { should validate_numericality_of(:active_participants).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:participants)}
  it { should validate_presence_of(:category)}
  it { should validate_presence_of(:tag)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:datetime).on(:create)}
end
