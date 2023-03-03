class CreateProjectSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :project_skills do |t|
      # t.references :project, null: false, foreign_key: true
      # t.references :skill, null: false, foreign_key: true
      t.integer :level
      t.integer :skill_id 
      t.integer :project_id

      t.timestamps
    end
  end
end
