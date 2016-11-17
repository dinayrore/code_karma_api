# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  def show
    @developer = User.find params[:id]
    if @developer.account_type == 'Developer'
      @developer_dashboard_data = @developer.github_oauth_data
      render json: @developer_dashboard_data
    else
      render json: { error: @developer.errors.full_messages }, status: 403
    end
  end
end
