# require 'rails_helper'
# require 'sidekiq/testing'
#
# RSpec.describe NotifyQuarter, type: :job do
# 	Sidekiq::Testing.inline!
#
# 	let!(:reservation) { create(:reservation) }
#
#
#
# 	describe 'old reservation' do
# 		before {NotifyQuarter.perform_now }
# 		reservation.update_attribute(:start_date, Time.now - 15.minutes)
# 		reservation.update_attribute(:end_date, Time.now - 5.minutes)
# 		it { expect(Reservation.count).to eq(0) }
# 	end
# end
