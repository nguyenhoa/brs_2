class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :level
      t.integer :num_year
      t.timestamps
    end
  end
end
