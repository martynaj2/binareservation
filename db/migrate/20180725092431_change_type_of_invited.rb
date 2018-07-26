class ChangeTypeOfInvited < ActiveRecord::Migration[5.2]
  def change
    change_column :reservations, :invited_ids, :string
  end
end
