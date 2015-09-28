class AddActivityIdToRatings < ActiveRecord::Migration
  def change
    add_reference :ratings, :activity, index: true, foreign_key: true
  end
end
