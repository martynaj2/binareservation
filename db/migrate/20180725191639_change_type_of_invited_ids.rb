class ChangeTypeOfInvitedIds < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :invited_ids, :string
  end
end
