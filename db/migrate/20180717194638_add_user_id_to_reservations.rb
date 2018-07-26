class AddUserIdToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :user_id, :integer, index: true
  end
end
