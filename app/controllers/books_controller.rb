class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_book, only: [:edit, :update]
  def index
    @book = Book.new
    @favorite = Favorite.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    # @favorite = Favorite.new
    @book_comment = BookComment.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have creatad book successfully."
        redirect_to book_path(@book)
      else
        @books = Book.all
        @user = current_user
        flash.now[:alert] = "error"
        render :index
      end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)
    else
      render :'books/edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def correct_book
      book = Book.find(params[:id])
      if book.user != current_user
        redirect_to books_path
      end
  end
end