class CategoriesController < ApplicationController
  def index
    @activities = Activity.where(category: params["Category"])
  end
end