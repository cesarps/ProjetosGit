class AddCapaToAlbum < ActiveRecord::Migration
  def change
    add_column :albuns, :capa, :integer
  end
end
