# OAuth through GitHub to create user/developers
class DevelopersController < ApplicationController
  def show
    @user = User.find params[:id]
    if @user.account_type == 'Developer'
      @developer = @user.account
      render :show
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def update
    @user = User.find params[:id]
    @developer = @user.account
    if @user.account_type == 'Developer'
      @developer.update developer_params
      render json: @developer
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  def karma
    @user = User.find params[:id]
    @question_likes = KarmaQuestion.find("#{@user.account_id}").question_like
    @comment_likes = KarmaComment.find("#{@user.account_id}").comment_like
    @karma_points = Developer.find("#{@user.account_id}").karma_points
    if @user.account_type == 'Developer'
      total_karma_points = @question_likes + @comment_likes + @karma_points
      render json: total_karma_points
    else
      render json: { error: 'Incorrect User' }, status: 403
    end
  end

  private

  def developer_params
    params.permit(:skills)
  end
end
