# Index, Show, Post, Edit, Delete
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render :index
  end

  def show
    @project = Project.find params[:id]
    if @project.client == @current_user.account
      @client_projects = Project.where(client_id: @current_user.account.id)
      render json: @client_projects
    else
      render json: { error: @project.errors.full_messages }, status: 403
    end
  end

  def create
    @project = Project.new project_params
    @project.client_id = @current_user.id
    if @project.save
      render :show
    else
      render json: { errors: @project.errors.full_messages }, status: 422
    end
  end

  def update
    @project = Project.find params[:id]
    if @project.client == @current_user.account
      @project.update project_params
      render :show
    else
      render json: { error: @project.errors.full_messages}, status: 403
    end
  end

  def destroy
    @project = Project.find params[:id]
    if @project.client == @current_user.account
      @project.destroy
      render json: {}, status: :ok
    else
      render json: { error: @project.errors.full_messages }, status: 403
    end
  end

  def fork
    @project = Project.find params[:id]
    @developer = User.find_by(id: @current_user.id)
    if @developer.account_type == 'Developer'
      url = @project.github_repo_url
      owner_repo_array = url.scan(/https\:\/\/github\.com\/(\w*)\/(\w*)/).first
      owner = owner_repo_array[0]
      repo = owner_repo_array[1]
      github_api = "https://api.github.com/repos/#{owner}/#{repo}/forks"
      e = HTTParty.post(github_api,
      :headers => { 'Authorization' => "token #{@developer.github_token}",
                    'Content-Type' => 'application/json',
                    'User-Agent' => "Awesome-Octocat-App" }
      )
    else
      render json: { error: @project.errors.full_messages }, status: 422
    end
  end

  private

  def project_params
    params.permit(:title, :brief_description, :description, :github_repo_url,
                  :active_site_url, :fulfilled, :fix_type)
  end
end
