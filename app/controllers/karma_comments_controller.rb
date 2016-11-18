class KarmaCommentsController < ApplicationController
  def create
    @karmaquestion = KarmaQuestion.find(params[:karmaquestion_id])
    @new_comment = @karmaquestion.comments.new(karma_comment: params[:karma_comment])
    if @new_comment.save
      render json: @new_comment
    end
  end

  def update
    @edited_comment = KarmaComment.find(params[:id])
    if @edited_comment.update(karma_comment: params[:karma_comment])
      render json: @edited_comment
    end
  end

  def added_like
    @update_comment_like_button = KarmaQuestion.find(params[:id])
    if @update_comment_like_button.update(comment_like: params[:comment_like] + 1)
      render json: @update_comment_like_button
    end
  end

  def destroy
    @deleted_comment = KarmaComment.find params[:id]
    if @deleted_comment.developer_id == @current_user.id
      @deleted_comment.destroy
      render json: {}, status: :ok
    end
  end
end
