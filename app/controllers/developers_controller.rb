# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  def show
    @developer = User.find params[:id]
    if @developer.account_type == 'Developer'
      @developer_dashboard_data = @developer.github_oauth_data
      render json: @developer_dashboard_data
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def karma
    @user = User.find params[:id]
    @question_likes = KarmaQuestion.find("#{@user.account_id}").question_like
    @comment_likes = KarmaComment.find("#{@user.account_id}").comment_like
    @karma_points = Developer.find("#{@user.account_id}").karma_points
    if @user.account == @current_user.account
      total_karma_points = @question_likes + @comment_likes + @karma_points
      render json: total_karma_points
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end
end
