# Included in KarmaQuestionsController
module KarmaQuestionsHelper
  def find_question
    @question = KarmaQuestion.find params[:id]
  end

  def create_new_question
    @question = KarmaQuestion.new question_params
  end

  def set_account_id
    @question.developer_id = @current_user.account_id
  end

  def developer?
    @question.developer == @current_user.account
  end

  def account_confirmed
    @current_user.account_type == @question.developer.user.account_type
  end

  def save_question
    @question.save
    render 'show.json.jbuilder'
  end

  def update_question
    @question.update question_params
    render 'show.json.jbuilder'
  end

  def destroy_question
    @question.destroy
    render json: {}, status: :ok
  end

  def increment_question_like
    @question.update(question_like: params[:question_like].to_i + 1)
    render json: {}, status: :ok
  end

  def user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  private

  def question_params
    params.permit(:karma_question)
  end
end
