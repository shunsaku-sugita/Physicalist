class ItemsController < ApplicationController
  before_action :require_use_logged_in
  
  def show
    @item = Item.find(params[:id])
  end
  
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
end