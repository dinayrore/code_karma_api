# Index, Show, Post, Edit, Delete
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
    @project = Project.new project_params
    @project.client_id = @current_user.id
    if @project.save
      render :show
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 422
    end
  end

  def update
    @project = Project.find params[:id]
    if @project.client == @current_user.account
      @project.update project_params
      render :show
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 403
    end
  end

  def destroy
    @project = Project.find params[:id]
    if @project.client == @current_user.account
      @project.destroy
      render json: {}, status: :ok
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 403
    end
  end

  private

  def project_params
    params.permit(:title, :brief_description, :description, :github_repo_url,
                  :active_site_url, :fulfilled, :fix_type)
  end
end
