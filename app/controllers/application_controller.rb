# Main functionality of the app lives here
class ApplicationController < ActionController::Base
  before_action :check_user
  include SessionsHelper

  def current_user
    @current_user ||= User.find_by code_karma_token: params[:token]
  end

  def check_user
    if params[:token].nil?
      render json: { error: 'No Token' }, status: 401
    elsif current_user.nil?
      render json: { error: 'Invalid Token' }, status: 401
    end
  end
end
