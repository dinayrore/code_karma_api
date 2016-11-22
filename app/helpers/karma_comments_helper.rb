# Included in KarmaCommentsController
module KarmaCommentsHelper
  def verify_user
    @user = @current_user
  end

  def verify_account_type
    @user.account_type == 'Developer'
  end

  def set_account
    @comment.developer_id = @current_user.account_id
  end

  def verify_account
    @comment.developer == @current_user.account
  end

  def show_all_questions_and_comments
    @questions = KarmaQuestion.all
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
    render 'like.json.jbuilder'
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
