class AddCategoriaLegendaToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :legenda, :string
    add_column :fotos, :categoria_id, :integer
  end
end
