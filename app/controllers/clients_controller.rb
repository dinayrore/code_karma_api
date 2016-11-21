# OAuth through GitHub to create user/clients
class ClientsController < ApplicationController
  def show
    @user = User.find params[:id]
    if @user.account_type == 'Client'
      @client = @user.account
      render 'show.json.jbuilder'
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def update
    @user = User.find params[:id]
    if @user.account_type == 'Client'
      @client = @user.account
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
