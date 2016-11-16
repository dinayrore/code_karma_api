# Developer Projects Table holds foreign keys for projects and developers
class CreateDeveloperProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :developer_projects do |t|
      t.integer :percentage_complete, default: 0
      t.string :est_completion_date
      t.references :project, index: true, foreign_key: true
      t.references :developer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
