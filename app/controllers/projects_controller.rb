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
end
