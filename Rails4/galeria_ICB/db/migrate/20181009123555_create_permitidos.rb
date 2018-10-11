class CreatePermitidos < ActiveRecord::Migration
  def change
    create_table :permitidos do |t|
      t.references :usuario, index:true, foreign_key:true
      t.references :perfil, index:true, foreign_key:true
      t.timestamps null: false
    end
  end
end
