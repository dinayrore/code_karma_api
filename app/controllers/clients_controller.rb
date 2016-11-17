class ClientsController < ApplicationController
  def show
    @client = User.find_by(account_id: @current_user.id)
    @client_dashboard_data = @client.github_oauth_data
    render json: @client_dashboard_data
  end
end
