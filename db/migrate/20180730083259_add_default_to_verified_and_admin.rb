class AddDefaultToVerifiedAndAdmin < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :verified, :boolean, default: false
    change_column :users, :premium, :boolean, default: false
    change_column :users, :admin, :boolean, default: false
    change_column :users, :vacation, :boolean, default: false  
  end
end
