# Community Feed Questions Controller
class KarmaQuestionsController < ApplicationController
  include KarmaQuestionsHelper

  def create
    create_new_question
    set_account_id
    if developer?
      save_question
      update_question_karma_points
    else
      user_error
    end
  end

  def update
    find_question
    if developer?
      update_question
    else
      user_error
    end
  end

  def destroy
    find_question
    if developer?
      destroy_question
    else
      user_error
    end
  end

  def like
    find_question
    if account_confirmed
      increment_question_like
    else
      user_error
    end
  end
end
