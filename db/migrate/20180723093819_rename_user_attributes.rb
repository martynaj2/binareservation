class RenameUserAttributes < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :is_premium, :premium
    rename_column :users, :is_admin, :admin
    rename_column :users, :is_verified, :verified
    rename_column :reservations, :invited, :invited_ids
  end
end
