# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception, with: :handle_exception

  DEFAULT_PER_PAGE = 15

  def action_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  protected
  USER_ADDITIONAL_ATTRIBUTES = %i[access_type name phone address image gender]

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: USER_ADDITIONAL_ATTRIBUTES)
    devise_parameter_sanitizer.permit(:account_update, keys: USER_ADDITIONAL_ATTRIBUTES)
  end

  def handle_exception(error)
    raise unless error.is_a?(Pundit::NotAuthorizedError)

    respond_to do |format|
      format.html { redirect_to root_url, notice: "You don't have access to this page." }
      format.json { head :no_content, status: :access_denied }
    end
  end
end
