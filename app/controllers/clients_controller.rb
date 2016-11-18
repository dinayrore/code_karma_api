# OAuth through GitHub to create user/clients
class ClientsController < ApplicationController
  def show
    @client = User.find params[:id]
    if @client.account_type == 'Client'
      @client_dashboard_data = @client.github_oauth_data
      render json: @client_dashboard_data
    else
      render json: { error: @client.errors.full_messages }, status: 403
    end
  end
end
