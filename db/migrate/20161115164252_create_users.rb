# Users table polymorphic relationships set through account_id, account_type
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :account_id
      t.string :account_type
      t.string :code_karma_token
      t.string :github_token
      t.json :github_oauth_data
      t.string :email

      t.timestamp
    end
  end
end
