class Tipo < ActiveRecord::Base

  has_many :tipo_usuarios, dependent: :destroy
  has_many :events
  has_and_belongs_to_many :tipo_usuarios
  validates_presence_of :nome

  after_create :inserir_permissoes_para_novo_tipo

  private
	  def inserir_permissoes_para_novo_tipo
	  	usuarios=Usuario.all
	  	usuarios.each do |usr|
	  		TipoUsuario.create(usuario_id: usr.id, tipo_id: self.id)
	  	end
	  end

end
