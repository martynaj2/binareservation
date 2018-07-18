require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'atrributes' do
    it {expect(subject.attributes).to include('name', 'surname') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_length_of(:surname).is_at_least(2) }
  end

  describe '#fullname' do
      let(:user) { user = User.create(
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
      ) }
    it 'should have working #fullname method' do
      expect(user.fullname).to eq("#{user.name} #{user.surname}")
    end
  end

  describe 'associations' do
    it { should have_many(:reservations) }
  end
end
