class ChangeNames < ActiveRecord::Migration
  def change
    rename_column :activities, :type, :tag
  end
end
