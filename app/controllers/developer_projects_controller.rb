# Show, Create, Update, Delete
class DeveloperProjectsController < ApplicationController
  include DeveloperProjectsHelper

  def show
    find_developer_by_user_id
    if verify_account_type
      show_my_projects
    else
      wrong_user_error
    end
  end

  def create
    new_dev_project
    if authorized_developer?
      save_dev_project
    else
      wrong_syntax_error
    end
  end

  def update
    find_dev_project_by_id
    if authorized_developer?
      edit_dev_project
    else
      wrong_user_error
    end
  end

  def destroy
    find_dev_project_by_id
    if authorized_developer?
      delete_dev_project
    else
      wrong_user_error
    end
  end

  def pull_request
    # create
    # set_current_user
    # get_github_project_branches
    post_pull_request
  end
end
