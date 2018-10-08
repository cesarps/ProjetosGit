class AddSubtitleToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :subtitle, :string
  end
end
