class SearchesController < ApplicationController
  def search
    @model_selection = params[:model_selection]
    @retrieval_method = params[:retrieval_method]

    if @retrieval_method == "perfect_match"
      @word = "#{params[:word]}"
    elsif @retrieval_method == "forward_match"
      @word = "#{params[:word]}%"
    elsif @retrieval_method == "backward_match"
      @word = "%#{params[:word]}"
    elsif @retrieval_method == "partial_match"
      @word = "%#{params[:word]}%"
    end

    if @model_selection == "User"
      @users = User.where("name LIKE ?", "#{@word}").or(User.where("introduction LIKE ?", "#{@word}"))
    else
      @books = Book.where("title LIKE ?", "#{@word}").or(Book.where("body LIKE ?", "#{@word}"))
    end
  end

  def tag_search
    @tag = params[:tag]
    @books = Tag.find_by("name LIKE ?", "%#{@tag}%").books
  end
end
