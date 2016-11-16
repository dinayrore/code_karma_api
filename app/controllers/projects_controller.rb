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
