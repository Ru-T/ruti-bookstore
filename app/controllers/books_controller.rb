class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).page(params[:page])
    # .order(params[:sort])
    # <% if params[:sort] == "created_at" %>
    #   <%=link_to 'Newest', crops_path(:sort => "created_at") %>
    # <% end %>

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
