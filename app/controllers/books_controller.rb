class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy ]

  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @book_comment = BookComment.new
    @book_comments = @book.book_comments

    current_room_enter = RoomEnter.where(user_id: current_user.id)
    another_room_enter = RoomEnter.where(user_id: @book.user.id)

    if current_user.id != @book.user.id
      current_room_enter.each do |c|
        another_room_enter.each do |a|
          if a.room_id == c.room_id
            @roomId = Room.find(c.room_id)
          end
        end
      end
    end

    view_count = ViewCount.new
    view_count.book_id = @book.id
    view_count.user_id = current_user.id
    view_count.save
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day

    @book = Book.new
    @books = Book.all.sort { |a, b| b.favorites.where(created_at: from...to).count <=> a.favorites.where(created_at: from...to).count }
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :rate)
    end
end
