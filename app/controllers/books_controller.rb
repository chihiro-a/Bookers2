class BooksController < ApplicationController
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # idがnillでエラーになる
    @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    # 投稿詳細へリダイレクト
  end
  
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
    # 投稿詳細へリダイレクト
    flash[:notice] = "You have updated book successfully."
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
