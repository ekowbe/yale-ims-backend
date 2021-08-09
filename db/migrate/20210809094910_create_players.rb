class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :team, null: false, foreign_key: true
      t.integer :class_of

      t.timestamps
    end
  end
end
