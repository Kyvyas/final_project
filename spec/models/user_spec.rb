require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :attendances }
  it { is_expected.to have_many :attended_activities }
  it { is_expected.to have_many :ratings }
end
