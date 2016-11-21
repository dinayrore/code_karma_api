##
module DevelopersHelper
  def find_user_by_id
    @user = User.find params[:id]
  end

  def is_developer?
    @user.account_type == 'Developer'
  end

  def display_developer_oauth_data
    @developer_oauth_data = @user.github_oauth_data
    render json: @developer_oauth_data
  end

  def aggregate_karma_variables
    @question_likes = KarmaQuestion.find("#{@user.account_id}").question_like
    @comment_likes = KarmaComment.find("#{@user.account_id}").comment_like
    @karma_points = Developer.find("#{@user.account_id}").karma_points
  end

  def calculate_total_karma
    total_karma_points = @question_likes + @comment_likes + @karma_points
    render json: total_karma_points
  end

  def wrong_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end
end
