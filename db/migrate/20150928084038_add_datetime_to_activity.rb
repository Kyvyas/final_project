class AddDatetimeToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :datetime, :datetime
  end
end
