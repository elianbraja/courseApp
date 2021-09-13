class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include PublicActivity::StoreController

  before_action :set_global_variables, if: :user_signed_in?

  def set_global_variables
    @course_search = Course.ransack(params[:course_search], search_key: :course_search)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
