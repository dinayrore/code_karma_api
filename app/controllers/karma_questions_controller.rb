# Community Feed Questions Controller
class KarmaQuestionsController < ApplicationController
  def index
    @show_all_questions = KarmaQuestion.all
    all_questions_and_comments = {}
    @show_all_questions.each do |question|
      all_questions_and_comments[question] = question.karma_comment
      show_all_questions_and_comments = all_questions_and_comments[question]
    end
    @user = @current_user
    if @user.account_type == 'Developer'
      render json: all_questions_and_comments
    else
      render json: { error: 'Incorrect User Type Match' }, status: 403
    end
  end

  def create
    @new_question = KarmaQuestion.new(
    karma_question: params[:karma_question],
    developer_id: @current_user.id
    )
    if @new_question.save
      render json: @new_question
    else
      render json: { error: @new_question.errors.full_messages }, status: 400
    end
  end

  def update
    @edited_question = KarmaQuestion.find(params[:id])
    if @edited_question.update(karma_question: params[:karma_question])
      render json: @edited_question
    else
      render json: { error: @edited_question.errors.full_messages }, status: 400
    end
  end

  def added_like
    @update_question_like_button = KarmaQuestion.find(params[:id])
    if @update_question_like_button.update(question_like: params[:question_like] + 1)
      render json: @update_question_like_button
    else
      render json: { error: @update_question_like_button.errors.full_messages }, status: 400
    end
  end

  def destroy
    @deleted_question = KarmaQuestion.find(params[:id])
    if @deleted_question.developer_id == @current_user.id
      @deleted_question.destroy
      render json: {}, status: :ok
    else
      render json: { error: @deleted_question.errors.full_messages }, status: 403
    end
  end
end
