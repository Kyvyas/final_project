class AddDefaultToColumnActiveParticipants < ActiveRecord::Migration
  def change
    change_column :activities, :active_participants, :integer, :default => 0
  end
end
