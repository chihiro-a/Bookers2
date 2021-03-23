class UsersController < ApplicationController
  
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
    # ユーザー詳細へリダイレクト
    flash[:notice] = "You have updated user successfully."
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @book = Book.new
    @users = User.all
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
