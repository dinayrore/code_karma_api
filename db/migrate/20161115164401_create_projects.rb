# Projects table foreign key to client
class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :brief_description, null: false
      t.string :description, null: false
      t.string :github_repo_url, null: false
      t.string :fix_type
      t.boolean :fulfilled, default: false
      t.references :client, index: true, foreign_key: true

      t.timestamps
    end
  end
end
