# Projects table
class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :brief_description
      t.string :description
      t.string :github_repo_url
      t.string :active_site_url
      t.boolean :fulfilled
      t.integer :client_id, foreign_key: true

      t.timestamps
    end
  end
end
