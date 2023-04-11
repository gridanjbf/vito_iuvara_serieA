class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :score, default: 0
      t.timestamps
    end
  end
end
