class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :acitivity, foreign_key: true
    end
  end
end
