class StaticPageController < ApplicationController
  def home
    redirect_to myads_path if current_user
  end
end
