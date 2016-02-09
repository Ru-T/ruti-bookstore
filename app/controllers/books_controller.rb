class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]

  def index
    if params[:sort] == "most_popular"
      @q = Book.most_popular
      @books = @q.result.page(params[:page])
    else
      @q = Book.ransack(params[:q])
      @books = @q.result.page(params[:page])
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
  # strong params
  def user_params
    params.require(:book).permit(
      :title,
      :published_date,
      :author,
      :price,
      :category,
      :description
    )
  end
end
