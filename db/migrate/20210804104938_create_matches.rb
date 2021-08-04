class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :name
      t.boolean :is_completed
      t.datetime :date_time

      t.timestamps
    end
  end
end
