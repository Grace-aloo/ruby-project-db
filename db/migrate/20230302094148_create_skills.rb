class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :name, limit:10
      t.string :tools 
      # t.integer :user_id  
      t.references :user, foreign_key: true    
      t.timestamps
    end

     add_index :skills, [:name, :user_id], unique: true
  end
end
