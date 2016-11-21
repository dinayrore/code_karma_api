# Index, Show, Post, Edit, Delete
class ProjectsController < ApplicationController
  include ProjectsHelper
  include DeveloperProjectsHelper

  def index
    set_current_user
    if is_developer?
      display_all_projects
    else
      wrong_user_error
    end
  end

  def show
    find_project_by_id
    if project_owner_client
      show_client_projects
    else
      wrong_user_error
    end
  end

  def create
    new_project
    if project_owner_client
      save_project
    else
      wrong_syntax_error
    end
  end

  def update
    find_project_by_id
    if project_owner_client
      edit_project
    else
      wrong_user_error
    end
  end

  def destroy
    find_project_by_id
    if project_owner_client
      delete_project
    else
      wrong_user_error
    end
  end

  def fork
    find_project_by_id
    set_current_user
    if is_developer?
      generate_fork_api_url
      if fork_request_github
        run_create_dev_project
      end
    else
      wrong_syntax_error
    end
  end
end
