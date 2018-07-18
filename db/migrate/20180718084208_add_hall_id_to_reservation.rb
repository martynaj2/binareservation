class AddHallIdToReservation < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :hall_id, :integer, index: true
  end
end
