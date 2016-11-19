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
    @client = User.find params[:id]
    if @client.account_type == 'Client'
      if !params[:organization_name].nil?
        @client.update params[:organization_name]
        render @client
      elsif !params[:organization_site].nil?
        @client.update params[:organization_name]
        render @client
      else
        render @client
      end
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end
end
