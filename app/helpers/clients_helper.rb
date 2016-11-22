module ClientsHelper
  def find_a_user
    @user = User.find params[:id]
  end

  def confirm_account_type_client
    @user.account_type == 'Client'
  end

  def client_equals_user_account
    @client = @user.account
  end

  def github_oauth_data
    @client_dashboard_data = @user.github_oauth_data
  end

  def render_json_show
    render 'show.json.jbuilder'
  end

  def render_incorrect_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def update_client
    @client.update client_params
  end

  def render_json_client
    render json: @client
  end

  private

  def client_params
    params.permit(:organization_name, :organization_site)
  end
end
