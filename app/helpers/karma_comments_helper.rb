# Included in KarmaCommentsController
module KarmaCommentsHelper
  def verify_user
    @user = @current_user
  end

  def verify_account_type
    @user.account_type == 'Developer'
  end

  def account_confirmed
    @current_user.account_type == @comment.developer.user.account_type
  end

  def set_account
    @comment.developer_id = @current_user.account_id
  end

  def developer?
    @comment.developer == @current_user.account
  end

  def show_all_questions_and_comments
    @questions = KarmaQuestion.order('created_at')
    render 'index.json.jbuilder'
  end

  def create_new_comment
    @comment = KarmaComment.new comment_params
  end

  def save_comment
    @comment.save
    render 'show.json.jbuilder'
  end

  def find_comment
    @comment = KarmaComment.find params[:id]
  end

  def update_comment
    @comment.update(karma_comment: params[:karma_comment])
    render 'show.json.jbuilder'
  end

  def destroy_comment
    @comment.destroy
    render json: {}, status: :ok
  end

  def increment_like
    @comment.update(comment_like: params[:comment_like].to_i + 1)
    render json: {}, status: :ok
  end

  def update_comment_karma_points
    comments = KarmaComment.where(id: KarmaComment.last.id)
    @comments = comments.length
    developer = Developer.find(@current_user.account_id)
    developer.karma_points = (@comments + 9) + developer.karma_points
    developer.save
  end

  def user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def syntax_error
    render json: { errors: 'Semantically Erroneous Instructions' }, status: 422
  end

  private

  def comment_params
    params.permit(:karma_comment, :karma_question_id)
  end
end
