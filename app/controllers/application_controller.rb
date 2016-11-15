class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_user

  def current_user
    @current_user ||= User.find_by api_token: params[:token]
  end

  def check_user
    if params[:token].nil?
      render json: { error: "No Token" }, status: 401
    elsif current_user.nil?
      render json: { error: "Invalid Token" }, status: 401
    end
  end
end
