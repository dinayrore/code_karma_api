#
module DeveloperProjectsHelper
  def set_current_user
    @user = @current_user
  end

  def authorized_developer?
    @developer_project.developer == @current_user.account
  end

  def show_dev_projects
    @developer_projects = DeveloperProject.where(developer_id: @current_user.account.id)
    render json: @developer_projects
  end

  def run_create_dev_project
    new_dev_project
    if authorized_developer?
      save_dev_project
    else
      wrong_syntax_error
    end
  end

  def new_dev_project
    @developer_project = DeveloperProject.new developer_project_params
    @developer_project.developer_id = @current_user.account.id
    @developer_project.project_id = params[:id]
  end

  def save_dev_project
    @developer_project.save
    render json: @developer_project
  end

  def edit_dev_project
    @developer_project.update developer_project_params
    render json: @developer_project
  end

  def delete_dev_project
    @developer_project.destroy
    render json: {}, status: :ok
  end

  def find_dev_project_by_id
    @developer_project = DeveloperProject.find params[:id]
  end

  def get_github_project_branches
    find_dev_project_by_id
    calculate_client_branch_request_url
    client_branch_request_github
    calculate_developer_branch_request_url
    developer_branch_request_github
  end

  def count_commits
    calculate_commit_request_url
    commit_request_github
  end

  def calculate_client_branch_request_url
    url = @developer_project.project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
    owner = owner_repo_array[0]
    repo = owner_repo_array[1]
    @client_branch_github_api_url = "https://api.github.com/repos/#{owner}/#{repo}/branches"
  end

  def calculate_commit_request_url
    url = @developer_project.project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
    owner = JSON.parse(@user.github_oauth_data)['info']['nickname']
    repo = owner_repo_array[1]
    @commit_github_api_url = "https://api.github.com/repos/#{owner}/#{repo}/stats/contributors"
  end

  def client_branch_request_github
    @client_branch_response = HTTParty.get(@client_branch_github_api_url,
      :headers => { 'Authorization' => "token #{@user.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API',
                    'protected' => 'false' }
    )
    @base_branches = []
  end

  def commit_request_github
    @commit_response = HTTParty.get(@commit_github_api_url,
      :headers => { 'Authorization' => "token #{@user.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API',
                    'protected' => 'false' }
    )
    if @commit_response[0]['author']['login'] == JSON.parse(@user.github_oauth_data)['info']['nickname']
      render json: @commit_response[0]['total']
    else
      render json: @commit_response[1]['total']
    end
  end

  def calculate_client_branch_request_url
    url = @developer_project.project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
    owner = owner_repo_array[0]
    repo = owner_repo_array[1]
    @developer_branch_github_api_url = "https://api.github.com/repos/#{owner}/#{repo}/branches"
  end

  def developer_branch_request_github
    @developer_branch_response = HTTParty.get(@developer_branch_github_api_url,
      :headers => { 'Authorization' => "token #{@user.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API',
                    'protected' => 'false' }
    )
    @head_branches = []
    render 'branches.json.jbuilder'
  end

  def post_pull_request
    find_dev_project_by_id
    set_current_user
    if authorized_developer?
      capture_owner_repo
      pull_request_params
      octokit_pull_request
    else
      wrong_syntax_error
    end
  end

  def capture_owner_repo
    url = @developer_project.project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
    @owner = owner_repo_array[0]
    @repo = owner_repo_array[1]
  end

  def pull_request_params
    @base_fork = "#{@owner}/#{@repo}"
    @base_branch = "master"

    @username = JSON.parse(@user.github_oauth_data)['info']['nickname']

    @head_fork = "#{@username}/#{@repo}"
    @head_branch = "new_test"

    @pull_title = "Kristine you should totally accept this Amazing Pull Request."
    @pull_body = "Like seriously plz accept it."
  end

  def octokit_pull_request
    client = Octokit::Client.new(:access_token => "#{@user.github_token}")
    client.create_pull_request("#{@owner}/#{@repo}", "#{@base_branch}", "#{@username}:#{@head_branch}",
    "#{@pull_title}", "#{@pull_body}")
  end

  def wrong_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def wrong_syntax_error
    render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
  end

  private

  def developer_project_params
    params.permit(:percentage_complete, :est_completion_date, :project_id)
  end
end

# def calculate_pull_request_url
#   # @pull_request_url = "https://api.github.com/#{@base_fork}/compare/#{@base_branch}...#{@username}:#{@head_branch}"
#   @pull_request_url = "https://api.github.com/repos/#{@owner}/#{@repo}/pulls"
# end
#
# def create_fork_pull_request
#   @fork_pull_response = HTTParty.post(@pull_request_url,
#     :headers => { 'Authorization' => "token #{@user.github_token}",
#                   'Content-Type' => 'application/json',
#                   'User-Agent' => 'Code-Karma-API'},
#
#     :body =>    {
#                   # 'base-fork' => "#{@base_fork}",
#                   # 'head-fork' => "#{@username}:#{@repo}",
#                   'title' => "#{@pull_title}",
#                   'base' => "#{@base_branch}",
#                   'head' => "#{@username}:#{@head_branch}",
#                   'body' => "#{@pull_body}"}
#   )
# end
