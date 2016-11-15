# Developer Projects Table holds foreign keys for projects and developers
class CreateDeveloperProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :developer_projects do |t|
      t.integer :project_id, foreign_key: true
      t.integer :developer_id, foreign_key: true

      t.timestamps
    end
  end
end
