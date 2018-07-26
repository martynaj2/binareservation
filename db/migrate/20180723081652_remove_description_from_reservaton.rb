class RemoveDescriptionFromReservaton < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :description, :string
  end
end
