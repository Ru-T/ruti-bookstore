class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page])
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
