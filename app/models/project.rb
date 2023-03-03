class Project < ActiveRecord::Base
    belongs_to :user
    # has_many :project_skills
    # has_many :skills, through: :project_skills
end