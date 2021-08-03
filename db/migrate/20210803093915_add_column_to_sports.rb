class AddColumnToSports < ActiveRecord::Migration[6.1]
  def change
    add_column :sports, :location, :string
  end
end
