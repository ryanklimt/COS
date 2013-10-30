class CreatePlayerMatches < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.float :score
      t.string :result
      t.references :player, index: true
      t.references :match, index: true

      t.timestamps
    end
  end
end