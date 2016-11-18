class KarmaQuestionsController < ApplicationController
  def index
    @show_all_questions = KarmaQuestion.all
    show_all_questions_and_comments = {}
    @show_all_questions.each do |question|
      show_all_questions_and_comments[question] = question.karma_comment
    end
    render json: show_all_questions_and_comments
  end

  def create
    @new_question = KarmaQuestion.new(
    karma_question: params[:karma_question],
    developer_id: @current_user.id
    )
    if @new_question.save
      render json: @new_question
    end
  end

  def update
    @edited_question = KarmaQuestion.find(params[:id])
    if @edited_question.update(karma_question: params[:karma_question])
      render json: @edited_question
    end
  end

  def added_like
    @update_question_like_button = KarmaQuestion.find(params[:id])
    if @update_question_like_button.update(question_like: params[:question_like] + 1)
      render json: @update_question_like_button
    end
  end

  def destroy
    @deleted_question = KarmaQuestion.find(params[:id])
    if @deleted_question.developer_id == @current_user.id
      @deleted_question.destroy
      render json: {}, status: :ok
    end
  end
end
