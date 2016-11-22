module KarmCommentsHelper
  def user_is_current_user
    @user = @current_user
  end

  def if_current_user_is_developer
    if @user.account_type == 'Developer'
  end

  def render_all_comments_and_questions
    @questions = KarmaQuestion.all
    render 'index.json.jbuilder'
  end

  def render_incorrect_user_error
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def create_comment
    @comment = KarmaComment.new comment_params
    @comment.developer_id = @current_user.account_id
  end

  def confirm_developer_and_save
    if @comment.developer == @current_user.account
      @comment.save
      render json: @comment
  end

  def render_instruction_error
    else
      render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
    end
  end

  def edit_comment
    @comment = KarmaComment.find params[:id]
  end

  def confirm_developer_and_save_update
    if @comment.developer == @current_user.account
      @comment.update(karma_comment: params[:karma_comment])
      render json: @comment
  end
  #render incorrect user error
  def destroy_comment
    @comment = KarmaComment.find params[:id]
  end

  def confirm_developer_for_destroy
    if @comment.developer == @current_user.account
      @comment.destroy
      render json: {}, status: :ok
  end
  #render incorrect user error
  def like_a_comment
    @comment = KarmaComment.find params[:id]
  end

  def confirm_developer_increment_like
    if @comment.developer.user.account_type == 'Developer'
      @comment.update(comment_like: params[:comment_like].to_i + 1)
      render json: @comment
  end
  #render instruction error
end
