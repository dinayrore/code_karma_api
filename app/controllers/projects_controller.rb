class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @clients = User.where(account_type: "Client")
    @clients.email
  end

  def show
    @client_projects = Project.where(client_id: @current_user.id)
    render json: @client_projects
  end

  # def create
  #   @added_project = Project.new(
  #   params[:title],
  #   params[:brief_description],
  #   params[:description],
  #   params[:github_repo_url]
  #   )
  # end
  #
  # def update
  #   @edited_project = Project.find(params[:id])
  # end
end
