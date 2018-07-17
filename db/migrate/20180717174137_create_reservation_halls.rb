class CreateReservationHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_halls do |t|
      t.integer :reservation_id, index: true
      t.integer :hall_id, index: true
    end
  end
end
