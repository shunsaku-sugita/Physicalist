class ItemsController < ApplicationController
  before_action :require_use_logged_in
  
  def new
    @items = []
    
    @keyword = params[:keyword]
    if @keyword
      begin
        title_results = RakutenWebService::Books::CD.search({
          title: @keyword,
        })
      rescue
        title_results = nil
      end
      
      begin
        artist_results = RakutenWebService::Books::CD.search({
          artist_name: @keyword,
        })
      rescue
        title_results = nil
      end
      
      title_results.each do |result|
        item = Item.new(read(result))
        @items << item
      end
      
      artist_results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
  end
  
  private
  
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
