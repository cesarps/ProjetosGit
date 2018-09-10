class MudaTipoDataFromAlbum < ActiveRecord::Migration
  def change
    change_column :albuns, :data_evento, :date
  end
end
