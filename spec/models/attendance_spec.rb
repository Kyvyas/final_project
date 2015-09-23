require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :activity }

end