class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @want_items = @user.want_items
    @count_want = @user.want_items.count
    @count_have = @user.have_items.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render 'new'
    end
  end
  
  def have_items
    @user = User.find(params[:id])
    @have_items = @user.have_items
    @count_have = @user.have_items.count
    @count_want = @user.want_items.count
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end