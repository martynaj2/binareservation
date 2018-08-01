class AddColorToHalls < ActiveRecord::Migration[5.2]
  def change
    add_column :halls, :hall_color, :string
  end
end
