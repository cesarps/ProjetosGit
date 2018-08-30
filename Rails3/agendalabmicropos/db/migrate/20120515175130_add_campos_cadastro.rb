class AddCamposCadastro < ActiveRecord::Migration
  def self.up
    add_column :usuarios,:cpf,:string
    add_column :usuarios,:rg,:string
    add_column :usuarios,:instituicao,:string
    add_column :usuarios,:email,:string
    add_column :usuarios,:tipo_id,:integer

  end

  def self.down
    remove_column :usuarios,:cpf
    remove_column :usuarios,:rg
    remove_column :usuarios,:instituicao
    remove_column :usuarios,:email
    remove_column :usuarios,:tipo_id

  end
end
