# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  include DevelopersHelper

  def show
    find_user_by_id
    if is_developer?
      display_developer_oauth_data
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
end
