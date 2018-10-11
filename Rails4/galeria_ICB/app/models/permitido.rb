class Permitido < ActiveRecord::Base

  belongs_to :usuario
  belongs_to :perfil

end
