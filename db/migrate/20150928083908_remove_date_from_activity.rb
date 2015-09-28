class RemoveDateFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :date, :date
  end
end
