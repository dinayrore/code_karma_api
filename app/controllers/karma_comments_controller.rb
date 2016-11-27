# Community Feed Comments Controller
class KarmaCommentsController < ApplicationController
  include KarmaCommentsHelper

  def index
    verify_user
    if verify_account_type
      show_all_questions_and_comments
    else
      user_error
    end
  end

  def create
    create_new_comment
    set_account
    if developer?
      save_comment
      update_comment_karma_points
    else
      syntax_error
    end
  end

  def update
    find_comment
    if developer?
      update_comment
    else
      user_error
    end
  end

  def destroy
    find_comment
    if developer?
      destroy_comment
    else
      user_error
    end
  end

  def like
    find_comment
    if account_confirmed
      increment_like
    else
      user_error
    end
  end
end
