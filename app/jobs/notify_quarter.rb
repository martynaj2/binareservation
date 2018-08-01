class NotifyQuarter < ApplicationJob
  queue_as :default

  def perform(*args)
    Reservation.mail_helper(args[0], 3)
  end
end
