class DeveloperProjectsController < ApplicationController
  def show
    @developer_projects = DeveloperProject.where(developer_id: @current_user.id)
    render json: @developer_projects
  end

  def create
    @developer_project = DeveloperProject.new developer_project_params
    if @developer_project.save
      render json: @developer_project
    else
      render :json => { :errors => @developer_project.errors.full_messages }, :status => 422
    end
  end

  def update
    @developer_project = DeveloperProject.find params[:id]
    if @developer_project.update developer_project_params
      render json: @developer_project
    else
      render :json => { :errors => @developer_project.errors.full_messages }, :status => 422
    end
  end

  private

  def developer_project_params
    params.permit(:percentage_complete, :est_completion_date,
                  :project_id, :developer_id)
  end
end
