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

  def client?
    @current_user.account_type == 'Client'
  end

  def project_owner_client
    @project.client == @current_user.account
  end

  def display_all_projects
    @projects = Project.all
    render 'index.json.jbuilder'
  end

  def find_client_projects
    @projects = Project.where(client_id: @current_user.account.id)
  end

  def show_client_projects
    render 'show.json.jbuilder'
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
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
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

  def get_github_project_languages
    generate_language_api_url
    set_current_user
    language_request_github
  end

  def generate_language_api_url
    url = @project.github_repo_url
    owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*-?\w*)\/(\w*-?\w*)/).first
    owner = owner_repo_array[0]
    repo = owner_repo_array[1]
    @github_language_api_url = "https://api.github.com/repos/#{owner}/#{repo}/languages"
  end

  def language_request_github
    @language_response = HTTParty.get(@github_language_api_url,
      :headers => { 'Authorization' => "token #{@user.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => 'Code-Karma-API' }
    )
    calculate_sum
    create_language_value
  end

  def calculate_sum
    @sum = 0
    @language_response.each do |language|
      @sum += language.second
    end
  end

  def create_language_value
    @language_percent = []
    @language_response.each do |language|
      @language_percent << {'language_name' => language.first,
                            'language_percent' => (language.second * 100) / @sum}
    end
    @project.languages = JSON.parse(@language_percent.to_json)
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
                  :active_site_url, :fulfilled, :fix_type, :languages)
  end
end
