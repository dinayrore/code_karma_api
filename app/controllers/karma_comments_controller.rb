class KarmaCommentsController < ApplicationController
  def create
    @karmaquestion = KarmaQuestion.find(params[:karmaquestion_id])
    @new_comment = @karmaquestion.comments.new(karma_comment: params[:karma_comment])
    if @new_comment.save
      render json: @new_comment
    else
      render json: { error: @new_comment.errors.full_messages }, status: 400
    end
  end

  def update
    @edited_comment = KarmaComment.find(params[:id])
    if @edited_comment.update(karma_comment: params[:karma_comment])
      render json: @edited_comment
    else
      render json: { error: @edited_comment.errors.full_messages }, status: 400
    end
  end

  def added_like
    @update_comment_like_button = KarmaQuestion.find(params[:id])
    if @update_comment_like_button.update(comment_like: params[:comment_like] + 1)
      render json: @update_comment_like_button
    else
      render json: { error: @update_comment_like_button.errors.full_messages }, status: 400
    end
  end

  def destroy
    @deleted_comment = KarmaComment.find params[:id]
    if @deleted_comment.developer_id == @current_user.id
      @deleted_comment.destroy
      render json: {}, status: :ok
    else
      render json: { error: @deleted_comment.errors.full_messages }, status: 403
    end
  end
end
