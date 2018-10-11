class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :acao
      t.string :ip
      t.references :usuario, index:true, foreign_key:true
      t.timestamps null: false
    end
  end
end
