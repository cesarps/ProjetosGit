class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.integer :album_id
      t.string :arquivo

      t.timestamps null: false
    end
  end
end
