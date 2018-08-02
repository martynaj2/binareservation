require 'rails_helper'

RSpec.describe Reservation, type: :model do
	describe 'atrributes' do
		it {expect(subject.attributes).to include('title', 'start_date', 'end_date', 'user_id', 'hall_id', 'invited_ids') }
	end

	describe 'validations' do
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:start_date) }
		it { should validate_presence_of(:end_date) }
		it { should validate_length_of(:title).is_at_least(2).is_at_most(30) }
	end

	describe 'associations' do
		it { should belong_to(:user) }
		it { should belong_to(:hall) }
	end

	describe 'scopes' do
		let(:reservation1) { create(:reservation) }
		let(:reservation2) { create(:reservation, end_date: Time.now + 5.minutes) }

		it 'should have ended scope' do
			reservation1.update_attribute(:start_date, Time.now - 15.minutes)
			reservation1.update_attribute(:end_date, Time.now - 5.minutes)
			expect(Reservation.ended).to include(reservation1)
			expect(Reservation.ended).not_to include(reservation2)
		end

		it 'should have not_ended scope' do
			reservation1.update_attribute(:start_date, Time.now - 15.minutes)
			reservation1.update_attribute(:end_date, Time.now - 5.minutes)
			expect(Reservation.not_ended).not_to include(reservation1)
			expect(Reservation.not_ended).to include(reservation2)
		end

	end

	describe '#conflict_validation' do
		let(:reservation1) { create(:reservation, start_date: Time.now + 5.minutes, end_date: Time.now + 30.minutes ) }
		let(:reservation2) { create(:reservation, start_date: Time.now + 5.minutes, end_date: Time.now + 15.minutes ) }
		let(:reservation3) { create(:reservation, start_date: Time.now + 15.minutes, end_date: Time.now + 30.minutes ) }
		it 'should have working #conflict_validation method' do
			expect(Reservation.conflict_validation([reservation2, reservation3], reservation1)).to eq([reservation2, reservation3])
		end
	end
end
