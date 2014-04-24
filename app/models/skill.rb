class Skill < ActiveRecord::Base
  has_many :user_skills, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
end
