require 'rails_helper'

RSpec.describe Hall, type: :model do

  describe 'atrributes' do
    it {expect(subject.attributes).to include('title', 'capacity') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:capacity) }
    it { should validate_length_of(:title).is_at_least(1).is_at_most(10) }
  end

  describe 'associations' do
    it { should have_many(:reservations) }
    let(:hall) { create(:hall) }
    it { expect(hall).to have_many(:reservations).dependent(:destroy) }
  end

  describe 'scopes' do
    let(:hall1 ) { create(:hall, capacity: 5) }
    let(:hall2 ) { create(:hall, capacity: 10) }
    let(:hall3 ) { create(:hall, capacity: 20) }
    let(:hall4 ) { create(:hall, capacity: 21) }

    it 'should have small scope' do
      expect(Hall.small).to include(hall1)
      expect(Hall.medium).not_to include(hall1)
      expect(Hall.large).not_to include(hall1)
      expect(Hall.extra_large).not_to include(hall1)
    end

    it 'should have medium scope' do
      expect(Hall.small).not_to include(hall2)
      expect(Hall.medium).to include(hall2)
      expect(Hall.large).not_to include(hall2)
      expect(Hall.extra_large).not_to include(hall2)
    end

    it 'should have large scope' do
      expect(Hall.small).not_to include(hall3)
      expect(Hall.medium).not_to include(hall3)
      expect(Hall.large).to include(hall3)
      expect(Hall.extra_large).not_to include(hall3)
    end

    it 'should have extra_large scope' do
      expect(Hall.small).not_to include(hall4)
      expect(Hall.medium).not_to include(hall4)
      expect(Hall.large).not_to include(hall4)
      expect(Hall.extra_large).to include(hall4)
    end
  end
end
