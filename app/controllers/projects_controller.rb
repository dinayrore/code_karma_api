# Index, Show, Post, Edit
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render :index
  end

  def show
    @client_projects = Project.where(client_id: @current_user.id)
    render json: @client_projects
  end
end
