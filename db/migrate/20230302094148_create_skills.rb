class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.string :name, limit:10, null:false 
      t.string :tools 
      t.integer :user_id 
      t.integer :project_id     
      t.timestamps
    end

    add_index :skills, [:name, :user_id, :project_id], unique: true
  end
end
