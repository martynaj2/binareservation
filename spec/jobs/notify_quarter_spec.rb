# require 'rails_helper'
# require 'sidekiq/testing'
#
# RSpec.describe NotifyQuarter, type: :job do
# 	Sidekiq::Testing.inline!
#
# 	describe 'quarter notify' do
# 		let!(:reservation) { create(:reservation, start_date: Time.zone.now + 30.minutes) }
#
# 		it 'should check if mail is sent to queue' do
# 			# byebug
# 		  expect(NotifyQuarter.perform_later(reservation)).to change{Sidekiq::ScheduledSet.new.size}.by(1)
# 	 end
# 	end
# end
