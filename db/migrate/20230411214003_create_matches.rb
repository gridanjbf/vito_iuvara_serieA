class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :away, foreign_table: :teams, null: false
      t.references :home, foreign_table: :teams, null: false
      t.integer :home_score
      t.integer :away_score
      t.references :winner, foreign_table: :teams, null: true
      t.boolean :swapping
      t.integer :round
      t.string :season
      t.timestamps
    end
  end
end
