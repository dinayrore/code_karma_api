# Index, Show, Post, Edit, Delete
class ProjectsController < ApplicationController
  include ProjectsHelper

  def index
    set_current_user
    if current_developer
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
    if current_developer
      generate_fork_api
      fork_request_github
    else
      wrong_syntax_error
    end
  end

  def pull_request
    @developer_project = DeveloperProject.find params[:id]
    set_current_user
    if current_developer
      url = @developer_project.project.github_repo_url
      owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*)\/(\w*)/).first
      owner = owner_repo_array[0]
      repo = owner_repo_array[1]
      # pull_github_api = "https://api.github.com/repos/#{owner}/#{repo}/pulls"
      pull_github_api = "https://api.github.com/repos/kteich88/Practice-Rspec/pulls"
      pull_title = "Kristine you should totally accept this Amazing Pull Request."
      head_branch = "master"
      base_branch = "new_test"
      pull_body = "Like seriously plz accept it."

      HTTParty.post(pull_github_api,
      :headers => { 'Authorization' => "token #{@developer.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API'},

      :body =>    { 'title' => "#{pull_title}",
                    'base' => "#{base_branch}",
                    'head' => "#{head_branch}",
                    'body' => "#{pull_body}"}
      )
    else
      wrong_syntax_error
    end
  end

  private

  def project_params
    params.permit(:title, :brief_description, :description, :github_repo_url,
                  :fulfilled, :fix_type)
  end
end
