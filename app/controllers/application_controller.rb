class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_use_logged_in
    unless logged_in?
      redirect_to root_url
    end
  end
  
  def read(result)
    jan_code = result['jan']
    title = result['title']
    artist = result['artist_name']
    item_url = result['item_url']
    jacket_url = result['large_image_url']
    release_date = result['sales_date']
    
    return {
      jan_code: jan_code,
      title: title,
      artist: artist,
      item_url: item_url,
      jacket_url: jacket_url,
      release_date: release_date,
    }
  end
end
