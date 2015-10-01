class CategoriesController < ApplicationController
  def index
    @activities = Activity.where(category: params["Category"]).where(['datetime >= ?', DateTime.now]).order(datetime: :asc)
  end
end