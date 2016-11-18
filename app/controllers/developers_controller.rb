# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  def show
    @developer = User.find params[:id]
    if @developer.account_type == 'Developer'
      @developer_dashboard_data = @developer.github_oauth_data
      render json: @developer_dashboard_data
    else
      render json: { error: @developer.errors.full_messages }, status: 403
    end
  end

  def total_karma
    @developer_question = Developer.find(params[:id])
    developer_question_likes = @developer_question.karma_question.question_like

    @developer_comment = Developer.find(params[:id])
    developer_comment_likes = @developer_comment.karma_comment.comment_like

    @developer_points = Developer.find(params[:id])
    developer_karma_points = @developer_points.karma_points

    developer_karma_points + developer_comment_likes + developer_question_likes = total_karma_points
    if total_karma_points.save
      render json: total_karma_points
    else
      render json: { error: total_karma_points.errors.full_messages }, status: 400
    end
  end
end
