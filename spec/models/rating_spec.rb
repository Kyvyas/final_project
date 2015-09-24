require 'rails_helper'

describe Rating, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :activity }
end