class Foto < ActiveRecord::Base

  mount_uploader :arquivo, ArquivoUploader
  belongs_to :album
end
