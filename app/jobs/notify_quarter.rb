class NotifyQuarter < ApplicationJob
	queue_as :default

	def perform(*args)
		Reservation.delete_ended_reservations
	end
end
