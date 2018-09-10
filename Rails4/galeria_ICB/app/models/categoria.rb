class Categoria < ActiveRecord::Base
  has_many :albums
  has_many :fotos
end
