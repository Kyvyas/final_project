class AddTitleToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :title, :text
  end
end
