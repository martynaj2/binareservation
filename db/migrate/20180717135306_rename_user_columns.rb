class RenameUserColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :is_premium?, :is_premium
    rename_column :users, :is_admin?, :is_admin
    rename_column :users, :is_verified?, :is_verified
  end
end
