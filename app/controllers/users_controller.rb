class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    current_room_enter = RoomEnter.where(user_id: current_user.id)
    another_room_enter = RoomEnter.where(user_id: @user.id)

    if current_user.id != @user.id
      current_room_enter.each do |c|
        another_room_enter.each do |a|
          if a.room_id == c.room_id
            @roomId = Room.find(c.room_id)
          end
        end
      end
    end

    @today_post_count = @user.books.where(created_at: (Time.zone.now.beginning_of_day)..(Time.zone.now.end_of_day)).count
    @yesterday_post_count = @user.books.where(created_at: (Time.zone.now.beginning_of_day - 1.day)..(Time.zone.now.end_of_day - 1.day)).count
    @this_week_post_count = @user.books.where(created_at: (Time.zone.now.beginning_of_day - 6.day)..(Time.zone.now.end_of_day)).count
    @last_week_post_count = @user.books.where(created_at: (Time.zone.now.beginning_of_day - 13.day)..(Time.zone.now.end_of_day - 7.day)).count

    if @yesterday_post_count = 0
      @day_before_ratio = "-"
    else
      @day_before_ratio = ((@today_post_count / @yesterday_post_count.to_f) * 100).floor
    end

    if @last_week_post_count = 0
      @week_before_ratio = "-"
    else
      @week_before_ratio = ((@this_week_post_count / @last_week_post_count.to_f) * 100).floor
    end
end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    search_day = params[:search_day]
    if search_day == ""
      @search_book = "日付を選択してください"
    else
      from = Time.parse(search_day).at_beginning_of_day
      to = Time.parse(search_day).at_end_of_day
      @search_book = Book.where(created_at: from..to).count
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        redirect_to user_path(current_user)
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
