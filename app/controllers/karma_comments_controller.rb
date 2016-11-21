# Community Feed Comments Controller
class KarmaCommentsController < ApplicationController
  def index
    @user = @current_user
    if @user.account_type == 'Developer'
      @questions = KarmaQuestion.all
      @comments = KarmaComment.all
      render 'index.json.jbuilder'
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def create
    @comment = KarmaComment.new comment_params
    @comment.developer_id = @current_user.account_id
    if @comment.developer == @current_user.account
      @comment.save
      render json: @comment
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  def update
    @comment = KarmaComment.find params[:id]
    if @comment.developer == @current_user.account
      @comment.update(karma_comment: params[:karma_comment])
      render json: @comment
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def destroy
    @comment = KarmaComment.find params[:id]
    if @comment.developer == @current_user.account
      @comment.destroy
      render json: {}, status: :ok
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def like
    @comment = KarmaComment.find params[:id]
    if @comment.developer.user.account_type == 'Developer'
      @comment.update(comment_like: params[:comment_like].to_i + 1)
      render json: @comment
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  private

  def comment_params
    params.permit(:karma_comment, :karma_question_id)
  end
end
