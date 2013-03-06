class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :given_name
      t.string :surname
      t.string :average
      t.integer :hr
      t.integer :rbi
      t.integer :runs
      t.integer :sb
      t.string :ops
      t.integer :team_id

      t.timestamps
    end
  end
end
