class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  
  def create
    book = Book.find(params[:book_id])
    book_comment = BookComment.new(book_comment_params)
    book_comment.user_id = current_user.id
    book_comment.book_id = book.id
    book_comment.save
    redirect_back fallback_location: books_path
  end

  def destroy
    book_comment = BookComment.find(params[:id])  
    book_comment.destroy
    redirect_back fallback_location: books_path
  end

  def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
    unless @book_comment.user_id == current_user.id
      redirect_to books_path
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
