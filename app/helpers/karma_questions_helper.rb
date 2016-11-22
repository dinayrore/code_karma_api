# Included in KarmaQuestionsController
module KarmaQuestionsHelper

  def create_new_question
    @question = KarmaQuestion.new question_params
  end

  def confirm_account_id
    @question.developer_id = @current_user.account_id
  end

  def confirm_developer_is_user
    @question.developer == @current_user.account
  end

  def save_question
    @question.save
  end

  def render_json
    render json: @question
  end

  def render_erronious_instruction_error
    render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
  end

  def find_a_question
    @question = KarmaQuestion.find params[:id]
  end

  def update_question
    @question.update question_params
  end

  def render_incorrect_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def confirm_account_type_developer
    @question.developer.user.account_type == 'Developer'
  end

  def increment_question_like
    @question.update(question_like: params[:question_like].to_i + 1)
  end

  private

  def question_params
    params.permit(:karma_question)
  end
end
