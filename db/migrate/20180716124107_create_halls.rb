class CreateHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :halls do |t|
      t.string :title
      t.integer :capacity
      t.timestamps
    end
  end
end
