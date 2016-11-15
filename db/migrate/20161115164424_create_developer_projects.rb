# Developer Projects Table holds foreign keys for projects and developers
class CreateDeveloperProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :developer_projects do |t|
      t.string :percentage_complete
      t.string :est_completion_date
      t.integer :project_id, foreign_key: true
      t.integer :developer_id, foreign_key: true

      t.timestamps
    end
  end
end
#percentage complete 0% default the edit
#completeion date, store
#completion date edit

#completion date shown
#percentage complete shown for client
#developer working on it
