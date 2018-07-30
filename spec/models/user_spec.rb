require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'atrributes' do
    it {expect(subject.attributes).to include('name', 'surname') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(15) }
    it { should validate_length_of(:surname).is_at_least(2).is_at_most(15) }
    it { should validate_length_of(:email).is_at_least(2).is_at_most(50) }
  end

  describe 'associations' do
    it { should have_many(:reservations) }
    it { should have_many(:group).through(:group_users) }
    let(:user) { create(:user) }
    it { expect(user).to have_many(:reservations).dependent(:destroy) }
  end

  describe 'scopes' do
    let(:user1) { create(:user, verified: true) }
    let(:user2) { create(:user, verified: false) }

    it 'should have not verified scope' do
      expect(User.not_verified).to include(user2)
      expect(User.not_verified).not_to include(user1)
    end
  end

  describe '#fullname' do
      let(:user) { create(:user) }
    it 'should have working #fullname method' do
      expect(user.fullname).to eq("#{user.name} #{user.surname}")
    end
  end

end
