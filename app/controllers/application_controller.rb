class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include PublicActivity::StoreController

  before_action :set_global_variables, if: :user_signed_in?

  def set_global_variables
    @course_search = Course.ransack(params[:course_search], search_key: :course_search)
  end
end
