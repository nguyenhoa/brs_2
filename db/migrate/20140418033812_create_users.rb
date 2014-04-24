class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :birthday
      t.string :email
      t.boolean :role
      t.string :password_digest
      t.string :remember_token
      t.integer :team_id
      t.integer :position_id
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index  :users, :remember_token
  end
end
