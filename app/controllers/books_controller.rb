class BooksController < ApplicationController
  
  def new
     @book = Book.new
  end
  def create
    @book = book.new(book_params)
    @book.user_id = current_user_id
    @book.save
    redirect_to books_path
    # 投稿詳細へリダイレクト
  end
  
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def edit
  end
  
  def destroy
  end
  
  private
  
  def book_params
    params.require(:book).premit(:title, :body)
  end
  
end
