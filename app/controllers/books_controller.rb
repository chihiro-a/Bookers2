class BooksController < ApplicationController
  
  before_action :authenticate_user!
  # ログイン中ユーザのみ使用できるようにする
  before_action :correct_book,only: [:edit]
  # 直打ちしてほしくないメソッドを指定する
  
  def correct_book
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
      # 投稿一覧へリダイレクト
    end
  end
  

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
      # 投稿詳細へリダイレクト
    else
      @books = Book.all
      # エラーメッセージ表示のために記述追加
      render ("books/index")
      # 投稿一覧へレンダー
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    @create_book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      # 投稿詳細へリダイレクト
      flash[:notice] = "You have updated book successfully."
    else
      render ('/books/edit')
      # タイトル内容空欄でエラーが出るように条件分岐
    end
  end
    
  
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    # 投稿一覧へリダイレクト
    
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
