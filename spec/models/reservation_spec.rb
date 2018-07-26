require 'rails_helper'

RSpec.describe Reservation, type: :model do
	describe 'atrributes' do
		it {expect(subject.attributes).to include('title', 'description', 'number_of_people', 'start_date', 'end_date', 'user_id', 'hall_id', 'invited') }
	end

	describe 'validations' do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:description) }
		it { should validate_presence_of(:number_of_people) }
		it { should validate_presence_of(:start_date) }
		it { should validate_presence_of(:end_date) }
		it { should validate_length_of(:title).is_at_least(5) }
		it { should validate_length_of(:description).is_at_least(10) }
	end

	describe 'associations' do
		it { should belong_to(:user) }
		it { should belong_to(:hall) }
	end
end
