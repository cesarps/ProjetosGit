class Foto < ActiveRecord::Base

  after_destroy :remove_file_directory




  mount_uploader :arquivo, ArquivoUploader
  belongs_to :album

  validates :arquivo, file_size: { less_than: 5.megabytes}

  def remove_file_directory
    path = File.expand_path(arquivo.store_path, arquivo.root)
    FileUtils.remove_dir(path, force: false)
  end



end