class RemoveTimeFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :time, :time
  end
end
