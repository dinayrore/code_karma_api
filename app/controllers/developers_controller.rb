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

  def rank
    leaderboard_order_by_descending
    leaderboard_total_developer_count
    render_rank
  end
end
