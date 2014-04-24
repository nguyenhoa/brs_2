class Project < ActiveRecord::Base
  has_many :user_projects, dependent: :destroy
  belongs_to :team
  validates :name, presence: true, length: { maximum: 50 }
  validates :short_name, length: {maximum:10}
  validates :team_id, presence: true
end
