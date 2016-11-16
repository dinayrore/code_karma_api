class DeveloperProjectsController < ApplicationController
  def create
    @completion_date = DeveloperProject.new(
    params[:est_completion_date]
    )
  end

  def update
    @update_project_status = DeveloperProject.find(params[:id])
  end
end
