class DropDateColumn < ActiveRecord::Migration
  def change
    remove_column :activities, :date
  end
end
