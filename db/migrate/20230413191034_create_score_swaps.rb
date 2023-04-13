class CreateScoreSwaps < ActiveRecord::Migration[7.0]
  def change
    create_table :score_swaps do |t|
      t.integer :winner_score
      t.integer :loser_score
      t.references :match, null: false
      t.timestamps
    end
  end
end
