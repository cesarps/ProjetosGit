class AddDiasDaSemanaToEvents < ActiveRecord::Migration
  def self.up
    add_column :events,:domingo,:boolean
    add_column :events,:segunda,:boolean
    add_column :events,:terca,:boolean
    add_column :events,:quarta,:boolean
    add_column :events,:quinta,:boolean
    add_column :events,:sexta,:boolean
    add_column :events,:sabado,:boolean
  end

  def self.down
    remove_column :events,:domingo
    remove_column :events,:segunda
    remove_column :events,:terca
    remove_column :events,:quarta
    remove_column :events,:quinta
    remove_column :events,:sexta
    remove_column :events,:sabado
  end
end
