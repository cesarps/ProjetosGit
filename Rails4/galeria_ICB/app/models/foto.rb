class Foto < ActiveRecord::Base

  after_destroy :remove_file_directory

  belongs_to :album
  belongs_to :categoria

  mount_uploader :arquivo, ArquivoUploader
  validates :arquivo, file_size: { less_than: 5.megabytes}
  validates_presence_of :arquivo
  validates_presence_of :legenda
  validates_presence_of :categoria_id

  def remove_file_directory
    path = File.expand_path(arquivo.store_path, arquivo.root)
    FileUtils.remove_dir(path, force: false)
  end
end
