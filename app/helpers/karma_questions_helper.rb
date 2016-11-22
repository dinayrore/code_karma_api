# Included in KarmaQuestionsController
module KarmaQuestionsHelper
  def create_question
    @question = KarmaQuestion.new question_params
    @question.developer_id = @current_user.account_id
  end

  def confirm_or_deny_creation_and_render
    if @question.developer == @current_user.account
      @question.save
      render json: @question
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  def find_a_question
    @question = KarmaQuestion.find params[:id]
  end

  def confirm_or_deny_update_and_render
    if @question.developer == @current_user.account
      @question.update question_params
      render json: @question
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def confirm_or_deny_like_and_render
    if @question.developer.user.account_type == 'Developer'
      @question.update(question_like: params[:question_like].to_i + 1)
      render json: @question
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  private

  def question_params
    params.permit(:karma_question)
  end
end
