class NotifyTwentyFour < ApplicationJob
  queue_as :default

  def perform(*args)
    Reservation.mail_helper(args[0], 4)
  end
end
