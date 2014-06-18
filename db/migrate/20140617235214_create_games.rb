class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :year
      t.integer :pos
      t.integer :goals

      t.timestamps
    end
  end
end
