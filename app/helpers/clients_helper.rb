# Included in ClientsController
module ClientsHelper
  def find_user
    @user = User.find params[:id]
  end

  def confirm_account_type
    @user.account_type == 'Client'
  end

  def identify_client
    @client = @user.account
    @client_dashboard_data = @user.github_oauth_data
  end

  def show_client_user_data
    render 'show.json.jbuilder'
  end

  def edit_client_params
    @client.update client_params
  end

  def user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  private

  def client_params
    params.permit(:organization_name, :organization_site)
  end
end
