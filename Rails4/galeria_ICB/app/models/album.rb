class Album < ActiveRecord::Base

  #before_destroy :remove_file_zip


  belongs_to :categoria
  belongs_to :departamento
  has_many :tags, dependent: :destroy
  has_many :fotos, dependent: :destroy



  accepts_nested_attributes_for :tags, :allow_destroy => true
  #accepts_nested_attributes_for :fotos, :allow_destroy => true, reject_if: proc { |a| a['arquivo'].blank? }
  accepts_nested_attributes_for :fotos, :allow_destroy => true


  validates_presence_of :data_evento
  validates_presence_of :nome_evento_assunto
  validates_presence_of :nome_fotografo

=begin
  def remove_file_zip
    id = @album.id
    path = "zips/" + id.to_s + ".zip"
    FileUtils.rm(path, force: true)
    redirect_to albuns_path
  end
=end


end
