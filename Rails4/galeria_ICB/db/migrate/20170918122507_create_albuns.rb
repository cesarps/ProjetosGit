class CreateAlbuns < ActiveRecord::Migration
  def change
    create_table :albuns do |t|
      t.string :data_evento
      t.text :nome_evento_assunto
      t.integer :departamento_id
      t.string :nome_fotografo
      t.text :endereco
      t.integer :categoria_id

      t.timestamps null: false
    end
  end
end
