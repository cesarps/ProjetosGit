class Perfil < ActiveRecord::Base

  has_many :permitidos
  has_many :usuarios, through: :permitidos

end
