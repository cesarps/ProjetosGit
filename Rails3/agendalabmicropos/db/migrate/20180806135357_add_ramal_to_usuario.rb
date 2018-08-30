class AddRamalToUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :ramal, :string
  end

  def self.down
    remove_column :usuarios, :ramal
  end
end
