# OAuth through GitHub to create user/clients
class ClientsController < ApplicationController
  def show
    @client = User.find params[:id]
    if @client.account_type == 'Client'
      @client_dashboard_data = @client.github_oauth_data
      render json: @client_dashboard_data
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def update
    @user = User.find params[:id]
    @client = @user.account
    if @user.account_type == 'Client'
      @client.update client_params
      render json: @client
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  private

  def client_params
    params.permit(:organization_name, :organization_site)
  end
end
