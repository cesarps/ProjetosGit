class RemoveCamposCadastro < ActiveRecord::Migration
  def self.up
    remove_column :usuarios,:tipo_id
    add_column :usuarios ,:vinculo_id,:integer

  end

  def self.down
    add_column :usuarios,:tipo_id,:integer
    remove_column :usuarios,:vinculo_id

  end
end
