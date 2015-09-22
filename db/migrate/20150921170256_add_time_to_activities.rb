class AddTimeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :time, :time
  end
end
