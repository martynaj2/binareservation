require'rails_helper'
describe	'Whenever	Schedule' do
	describe	'runners' do
		let(:schedule) { Whenever::Test::Schedule.new(file:'config/schedule.rb') }
		it	{	expect(schedule.jobs[:runner].count).to	eq(1)	}
		it	'should	have runners	with	existing	constants' do
			schedule.jobs[:runner].each	{	|job|	instance_eval	job[:task] }
		end
		describe	'#delete_old_authors' do
			let(:ended_reservations_runner)	do
				schedule.jobs[:runner].find	do |runner|
					runner[:task]	==	'Reservation.delete_ended_reservations'
				end
			end
			it	'should	run	every	sunday at	3pm' do
				expect(ended_reservations_runner[:every]).to eq([:sunday,	{ at:'3am' }])
			end
		end
	end
end
