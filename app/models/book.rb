class Book < ActiveRecord::Base
  validates_presence_of :title, :published_date, :author, :price

  # def self.order_by(sort_column, sort_direction)
  #   # sortable_columns = ["title", "published_date", "author", "price", "category"]
  #   # sort_column = sortable_columns.include?(params[:column]) ? params[:column] : "published_date"
  #   # sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  #   sort_column ||= "published_date"
  #   sort_direction ||= :desc
  # end
end
