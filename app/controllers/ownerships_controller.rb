class OwnershipsController < ApplicationController
  def new
    @item = Item.find_or_initialize_by(jan_code: params[:jan_code])
    
    unless @item.persisted?
      results = RakutenWebService::Books::CD.search(jan: @item.jan_code)
      @item = Item.new(read(results.first))
    end
    @ownership = Ownership.new
  end
    
  def create
    @item = Item.find_or_initialize_by(jan_code: params[:jan_code])
    
    unless @item.persisted?
      results = RakutenWebService::Books::CD.search(jan: @item.jan_code)
      @item = Item.new(read(results.first))
      @item.save
    end
  
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = 'ウォントリストに追加しました。'
    else
      params[:type] == 'Have'
      current_user.have(@item, params[:ownership][:format], params[:ownership][:price], params[:ownership][:get_date])
      flash[:success] = 'マイシェルフに追加しました。'
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = 'ウォントリストから削除しました。'
    else
      params[:type] == 'Have'
      current_user.unhave(@item)
      flash[:success] = 'マイシェルフから削除しました。'
    end
    
    redirect_back(fallback_location: root_path)
  end
end