class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :description
      t.text :location
      t.integer :participants
      t.integer :active_participants
      t.time :date
      t.text :category
      t.text :tag

      t.timestamps null: false
    end
  end
end
