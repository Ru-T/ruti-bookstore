class BooksController < ApplicationController
  def index
    @books = Book.all.paginate(page: params[:page])
  end

  private

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
