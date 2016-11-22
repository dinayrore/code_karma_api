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
    if verify_account
      save_comment
    else
      syntax_error
    end
  end

  def update
    find_comment
    if verify_account
      update_comment
    else
      user_error
    end
  end

  def destroy
    find_comment
    if verify_account
      destroy_comment
    else
      user_error
    end
  end

  def like
    find_comment
    if verify_account
      increment_like
    else
      user_error
    end
  end
end
