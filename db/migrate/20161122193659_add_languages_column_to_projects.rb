class AddLanguagesColumnToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :languages, :json
  end
end
