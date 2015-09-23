require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :attendances }
  it { should validate_numericality_of(:participants).is_greater_than(0) }
  it { should validate_numericality_of(:active_participants).is_greater_than_or_equal_to(0) }
end