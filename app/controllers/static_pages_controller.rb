class StaticPagesController < ApplicationController
  def home

    if loged_in?
      @micropost = current_user.microposts.build if loged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    
  end

  def help
  end

  def about

  end

  def contact

  end
end
