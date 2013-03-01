class CreateGameAndGuesses < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.string :answer
      t.boolean :active
      t.timestamps
    end
    create_table :guesses do |t|
      t.belongs_to :game
      t.string :guess
      t.timestamps
    end
  end
end
