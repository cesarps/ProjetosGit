class AddRamalToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :ramal, :string
  end

  def self.down
    remove_column :events, :ramal
  end
end
