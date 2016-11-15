# Developers table
class CreateDevelopers < ActiveRecord::Migration[5.0]
  def change
    create_table :developers do |t|
      t.integer :user_id, foreign_key: :true
      t.integer :karma_points
    end
  end
end
