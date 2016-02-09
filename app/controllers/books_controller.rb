class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]

  def index
    sort = params[:sort] || "published_date"
    sort = "purchase_count" if sort == "most_popular"
    @q = Book.order(sort).ransack(params[:q])
    @books = @q.result.page(params[:page])
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
