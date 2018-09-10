class Album < ActiveRecord::Base
  belongs_to :categoria
  belongs_to :departamento
  has_many :tags, dependent: :destroy
  has_many :fotos, dependent: :destroy

  accepts_nested_attributes_for :tags, :allow_destroy => true
  accepts_nested_attributes_for :fotos, :allow_destroy => true, reject_if: proc { |a| a['arquivo'].blank? }

  validates_presence_of :data_evento
  validates_presence_of :nome_evento_assunto
  validates_presence_of :nome_fotografo





end
