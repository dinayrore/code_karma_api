# Client table
class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.integer :user_id, foreign_key: :true
    end
  end
end
