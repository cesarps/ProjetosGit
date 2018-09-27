class AddLegendaToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :legenda, :string
  end
end
