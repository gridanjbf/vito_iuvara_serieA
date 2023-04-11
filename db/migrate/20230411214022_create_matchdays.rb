class CreateMatchdays < ActiveRecord::Migration[7.0]
  def change
    create_table :matchdays do |t|
      t.integer :sequence_number, null: false
      t.string :match_years, null: false
      t.timestamps
    end
  end
end
