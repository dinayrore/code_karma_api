# Show, Create, Update, Delete
class DeveloperProjectsController < ApplicationController
  include DeveloperProjectsHelper

  def show
    find_dev_project_by_id
    if authorized
      show_dev_projects
    else
      wrong_user_error
    end
  end

  def create
    new_dev_project
    if authorized
      save_dev_project
    else
      wrong_syntax_error
    end
  end

  def update
    find_dev_project_by_id
    if authorized
      edit_dev_project
    else
      wrong_user_error
    end
  end

  def destroy
    find_dev_project_by_id
    if authorized
      delete_dev_project
    else
      wrong_user_error
    end
  end

  private

  def developer_project_params
    params.permit(:percentage_complete, :est_completion_date, :project_id)
  end
end
