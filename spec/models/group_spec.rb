require 'rails_helper'

RSpec.describe Group, type: :model do

  describe 'atrributes' do
    it {expect(subject.attributes).to include('title') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  describe 'associations' do
    it { should have_many(:group_users) }
  end
end
