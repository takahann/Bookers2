class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:id)
    comment = current_user.book_comments.new(book_comment_params)
    book_comment.save
    @book_comments = Book.find(params[:book_id])
    redirect_to book_path
  end

private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end