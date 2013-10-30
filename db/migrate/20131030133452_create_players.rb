class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :file_location
      t.text :description
      t.string :name
      t.boolean :downloadable, default: => false
      t.boolean :playable, default: => true
      t.references :user, index: => true
      t.references :contest, index: => true

      t.timestamps
    end
  end
end