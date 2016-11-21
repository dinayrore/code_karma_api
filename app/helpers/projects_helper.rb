#
module ProjectsHelper
  def set_current_user
    @user = @current_user
  end

  def alternate_fork_set_current_user
    @user = User.find_by(id: @current_user.id)
  end

  def is_developer?
    @user.account_type == 'Developer'
  end

  def project_owner_client
    @project.client == @current_user.account
  end

  def display_all_projects
    @projects = Project.all
    render 'index.json.jbuilder'
  end

  def show_client_projects
    @client_projects = Project.where(client_id: @current_user.account.id)
    render json: @client_projects
  end

  def new_project
    @project = Project.new project_params
    @project.client_id = @current_user.account.id
  end

  def save_project
    @project.save
    render 'show.json.jbuilder'
  end

  def edit_project
    @project.update project_params
    render 'show.json.jbuilder'
  end

  def delete_project
    @project.destroy
    render json: {}, status: :ok
  end

  def generate_fork_api_url
    url = @project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*)\/(\w*)/).first
    owner = owner_repo_array[0]
    repo = owner_repo_array[1]
    @github_fork_api_url = "https://api.github.com/repos/#{owner}/#{repo}/forks"
  end

  def fork_request_github
    HTTParty.post(@github_fork_api_url,
      :headers => { 'Authorization' => "token #{@user.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API' }
    )
  end

  def find_project_by_id
    @project = Project.find params[:id]
  end

  def wrong_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def wrong_syntax_error
    render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
  end

  private

  def project_params
    params.permit(:title, :brief_description, :description, :github_repo_url,
                  :fulfilled, :fix_type)
  end
end
