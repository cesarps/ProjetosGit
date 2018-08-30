class ConfirmacaoRestrito < ActiveRecord::Migration
  def self.up
    add_column :tipos,:confirmacao,:boolean
    add_column :tipos,:restricao,:integer
  end

  def self.down
    remove_column :tipos,:confirmacao
    remove_column :tipos,:restricao
  end
end
