class Categoria < ActiveRecord::Base
  has_many :albums
  has_many :fotos

  validates_presence_of :nome
end
