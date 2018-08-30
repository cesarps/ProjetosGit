class AddColumnRegpara < ActiveRecord::Migration
  def self.up
    add_column :events,:regpara,:string
  end

  def self.down
    remove_column :events,:regpara
  end
end

