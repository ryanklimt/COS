class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.string :file_location
      t.string :name
      t.string :rules_url
      t.integer :players_per_game
      t.references :user, index: true

      t.timestamps
    end
  end
end