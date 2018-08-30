class CreateTipoUsuario < ActiveRecord::Migration
  def self.up
    create_table :tipo_usuario do |t|
          t.integer :tipo_id
          t.integer :usuario_id
          t.timestamps
        end
  end

  def self.down
    drop_table :tipo_usuario
  end
end
