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

  def create
    @added_project = Project.new(
    params[:title],
    params[:brief_description],
    params[:description],
    params[:github_repo_url]
    )
  end

  def update
    @edited_project = Project.find(params[:id])
    @project = Project.new project_params
    if @project.save
      render :show
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 422
    end
  end

  def update
    @project = Project.find params[:id]
    if @project.update project_params
      render :show
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 422
    end
  end

  private

  def project_params
    params.permit(:title, :brief_description, :description, :github_repo_url,
                  :active_site_url, :fulfilled, :fix_type, :client_id)
  end
end
