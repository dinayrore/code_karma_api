# Community Feed Questions Controller
class KarmaQuestionsController < ApplicationController
  def create
    @question = KarmaQuestion.new question_params
    @question.developer_id = @current_user.account_id
    if @question.developer == @current_user.account
      @question.save
      render json: @question
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  def update
    @question = KarmaQuestion.find params[:id]
    if @question.developer == @current_user.account
      @question.update question_params
      render json: @question
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def like
    @question = KarmaQuestion.find params[:id]
    if @comment.developer.user.account_type == 'Developer'
      @question.update(question_like: params[:question_like] + 1)
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
