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
end
