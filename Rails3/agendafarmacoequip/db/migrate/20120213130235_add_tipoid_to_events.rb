class AddTipoidToEvents < ActiveRecord::Migration
  def self.up
    add_column :events,:tipo_id,:integer
  end

  def self.down
    remove_column :events, :tipo_id
  end
end
