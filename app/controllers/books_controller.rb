class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]
  helper_method :sort_column, :sort_direction
  
  def index
    @books = Book.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 25)
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

  def sortable_columns
    ["title", "published_date", "author", "price", "category"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "published_date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
