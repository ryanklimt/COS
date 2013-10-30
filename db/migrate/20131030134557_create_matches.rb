class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :status
      t.date :completion
      t.datetime :earliest_start
      t.references :manager, polymorphic: true, index: true

      t.timestamps
    end
  end
end