class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  

  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    render json: { error: "No autorizado." }, status: :unauthorized unless @current_user
  end
end
