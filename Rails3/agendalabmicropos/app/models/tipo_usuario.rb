class TipoUsuario < ActiveRecord::Base
  belongs_to :tipo
  belongs_to :usuario
end
