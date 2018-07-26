require 'rails_helper'

RSpec.describe Hall, type: :model do

  describe 'atrributes' do
    it {expect(subject.attributes).to include('title', 'capacity') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:capacity) }
  end

  describe 'associations' do
    it { should have_many(:reservations) }
  end

  describe 'scopes' do
    let(:hall1 ) { create(:hall, title: 'test', capacity: 10) }
    let(:hall2 ) { create(:hall, title: 'test', capacity: 11) }

    it 'should have old scope' do
      expect(Hall.large).to include(hall2)
      expect(Hall.large).not_to include(hall1)
    end
  end
end
