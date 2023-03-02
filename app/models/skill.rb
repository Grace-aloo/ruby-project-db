class Skill < ActiveRecord::Base
    belongs_to :user
    has_many :project_skills
    has_many :projects, through: :project_skills
  end