class DevelopersController < ApplicationController
  def show
    @developer = User.find_by(account_id: @current_user.id)
    @developer_dashboard_data = @developer.github_oauth_data
    render json: @developer_dashboard_data
  end
end
