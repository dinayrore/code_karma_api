# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  include DevelopersHelper

  def show
    find_user_by_id
    if is_developer?
      find_developer_with_user
      display_developer
    else
      wrong_user_error
    end
  end

  def update
    find_user_by_id
    find_developer_with_user
    if is_developer?
      edit_developer_skills
    else
      wrong_user_error
    end
  end

  def karma
    find_user_by_id
    aggregate_karma_variables
    if is_developer?
      calculate_total_karma
      update_karma_points
    else
      wrong_user_error
    end
  end

  def rank
    @rank = Developer.order('karma_points DESC')
    @user_info = User.all
    render :rank
  end



  private

  def developer_params
    params.permit(:skills)
  end
end
