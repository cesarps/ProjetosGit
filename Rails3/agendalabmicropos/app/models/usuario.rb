class Usuario < ActiveRecord::Base

  has_many :tipo_usuarios, dependent: :destroy
  has_and_belongs_to_many :tipos
  has_many :events              #teste


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :nome_completo, :ramal

  after_create :inserir_permissoes_para_novo_usuario


  private
	  def inserir_permissoes_para_novo_usuario
	  	tipos=Tipo.all
	  	tipos.each do |tp|
	  		TipoUsuario.create(usuario_id: self.id, tipo_id: tp.id)
	  	end
	  end

end
