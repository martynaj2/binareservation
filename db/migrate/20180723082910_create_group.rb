class CreateGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string  :title
      t.integer :inviter
      t.integer :invited, array: true
      t.timestamps
    end
  end
end
