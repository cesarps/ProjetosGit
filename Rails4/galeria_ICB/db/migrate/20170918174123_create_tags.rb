class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :album_id
      t.string :nome

      t.timestamps null: false
    end
  end
end
