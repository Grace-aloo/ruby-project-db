class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null:false 
      t.string :image_src 
      t.string :description 
      t.string :site_link 
      t.string :git_link
      t.references :user, null: false, foreign_key: true
      # t.integer :user_id 
      t.timestamps
    end
    
  end
end
