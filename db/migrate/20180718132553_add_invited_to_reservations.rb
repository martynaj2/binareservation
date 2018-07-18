class AddInvitedToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :invited, :integer, array: true
  end
end
