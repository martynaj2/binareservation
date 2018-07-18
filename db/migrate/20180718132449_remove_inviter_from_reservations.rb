class RemoveInviterFromReservations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :inviter, :string
  end
end
