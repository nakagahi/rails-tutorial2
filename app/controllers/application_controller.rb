class ApplicationController < ActionController::Base

  include SessionsHelper

  private

  def logged_in_user

   unless loged_in?

     store_location

     flash[:danger] = "Please login!"


     redirect_to login_path

   end

  end
end
