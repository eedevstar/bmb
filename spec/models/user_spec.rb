require 'rails_helper'

describe User, type: :model do
  subject { build(:user) }

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).through(:posts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
