# Included in Developers Controller
module DevelopersHelper
  def find_user_by_id
    @user = User.find params[:id]
  end

  def find_developer_with_user
    @developer = @user.account
  end

  def is_developer?
    @user.account_type == 'Developer'
  end

  def display_developer
    @developer_dashboard_data = @user.github_oauth_data
    render 'show.json.jbuilder'
  end

  def aggregate_karma_questions
    questions = []
    questions << KarmaQuestion.find("#{@user.account_id}")
    @questions = questions.count
  end

  def aggregate_karma_comments
    comments = []
    comments << KarmaComment.find("#{@user.account_id}")
    @comments = comments.count
  end

  def aggregate_karma_likes
    question_likes = KarmaQuestion.find("#{@user.account_id}").question_like
    comment_likes = KarmaComment.find("#{@user.account_id}").comment_like
    @likes = (question_likes * 5) + (comment_likes * 5)
  end

  def calculate_total_karma
    @total_karma_points = @likes + (@comments * 10) + (@questions * 20)
    # pull_requests = 200 pts.
    # total_commits = 5 pts.
  end

  def update_karma_points
    @developer = Developer.find(@user.account_id)
    @developer.karma_points = @total_karma_points
    @developer_points = @total_karma_points
    @developer.save
    render json: @developer_points
  end

  def edit_developer_skills
    @developer.update developer_params
    render json: @developer
  end

  def wrong_user_error
    render json: { error: 'Incorrect User' }, status: 403
  end

  def leaderboard_total_developer_count
    @count = Developer.count
  end

  def leaderboard_order_by_descending
    @top_rank = Developer.order('karma_points DESC')
  end

  def render_rank
    render :rank
  end


  private

  def developer_params
    params.permit(:skills)
  end
end
