class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # ここ違うっぽいのであとで確認
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    # ユーザー詳細へリダイレクト
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
