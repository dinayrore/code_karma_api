# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  include DevelopersHelper

  def show
    find_user_by_id
    if is_developer?
      display_developer_oauth_data
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def update
    @user = User.find params[:id]
    @developer = @user.account
    if @user.account_type == 'Developer'
      @developer.update developer_params
      render json: @developer
    else
      wrong_user_error
    end
  end

  def karma
    find_user_by_id
    aggregate_karma_variables
    if is_developer?
      calculate_total_karma
    else
      wrong_user_error
    end
  end

  private

  def developer_params
    params.permit(:skills)
  end
end
