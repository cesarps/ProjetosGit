class CreateTipos < ActiveRecord::Migration
  def self.up
    create_table :tipos do |t|
      t.string :nome
      t.text :observacao

      t.timestamps
    end
  end

  def self.down
    drop_table :tipos
  end
end
