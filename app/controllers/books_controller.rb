class BooksController < ApplicationController
  before_action :set_book, only: [:show]

  def index
    @books = Book.all.paginate(page: params[:page], per_page: 25)
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
