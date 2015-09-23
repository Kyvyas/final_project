require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :attendances }
  it { should validate_presence_of(:date).on(:create)}
end
