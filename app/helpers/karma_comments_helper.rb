module KarmCommentsHelper
  def user_is_current_user
    @user = @current_user
  end

  def show_all_comments_and_questions
    if @user.account_type == 'Developer'
      @questions = KarmaQuestion.all
      render 'index.json.jbuilder'
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def find_a_comment
    @comment = KarmaComment.new comment_params
  end

  def confirm_or_deny_developer_and_save_comment
    @comment.developer_id = @current_user.account_id
    if @comment.developer == @current_user.account
      @comment.save
      render json: @comment
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  def confirm_or_deny_developer_and_render_update
    if @comment.developer == @current_user.account
      @comment.update(karma_comment: params[:karma_comment])
      render json: @comment
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def confirm_or_deny_developer_and_destroy_comment
    if @comment.developer == @current_user.account
      @comment.destroy
      render json: {}, status: :ok
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def confirm_or_deny_developer_increment_like
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
