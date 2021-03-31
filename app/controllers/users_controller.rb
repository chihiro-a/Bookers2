class UsersController < ApplicationController
  
  before_action :authenticate_user!
  # ログイン中ユーザのみ使用できるようにする
  before_action :correct_user,only: [:edit]
  # 直打ちしてほしくないメソッドを指定する
  
  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
      # 直打ちされた場合のリダイレクト先を指定
    end
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    # 自分が投稿したbookのみ取得
    # このbooksって具体的にどこを指している…？
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      # ユーザー詳細へリダイレクト
      flash[:notice] = "You have updated user successfully."
    else
      render ('/users/edit')
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end
  
  def index
    @book = Book.new
    @users = User.all
    @user = User.find(current_user.id)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
