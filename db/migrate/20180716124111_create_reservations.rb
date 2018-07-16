class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :title
      t.text :description
      t.integer :number_of_people
      t.datetime :start_date
      t.datetime :end_date
      t.string :inviter
      t.timestamps
    end
  end
end
