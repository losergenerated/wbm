class AddFieldsToGame < ActiveRecord::Migration
  def change
    change_table :games do |t| 
      t.string :charset
      t.string :guess_slots
    end
  end
end
