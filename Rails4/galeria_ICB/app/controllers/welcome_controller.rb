class WelcomeController < ApplicationController

  def login
    s = Senhaunica.new(ENV['ICB_OAUTH'],ENV['SECRET_OAUTH'],'2')
    redirect_to s.login()
  end

  def callback
    s = Senhaunica.new(ENV['ICB_OAUTH'],ENV['SECRET_OAUTH'],'2')
    @data = s.callback(params[:oauth_verifier])

    print @data

    loginUsuario = tratauser

    log_in loginUsuario

    carregaperfils

    addlog("Fez login no sistema")

  end

  def tratauser

    loginUsuario = @data["loginUsuario"]

    userexiste = Usuario.where(:loginUsuario => loginUsuario)

    if userexiste.empty?
      user = Usuario.new
    else
      user = Usuario.find_by_loginUsuario(loginUsuario)
    end

    user.loginUsuario = loginUsuario
    user.nomeUsuario = @data["nomeUsuario"]
    user.tipoUsuario = @data["tipoUsuario"]
    user.emailPrincipalUsuario = @data["emailPrincipalUsuario"]
    user.emailAlternativoUsuario = @data["emailAlternativoUsuario"]
    user.emailUspUsuario = @data["emailUspUsuario"]
    user.numeroTelefoneFormatado = @data["numeroTelefoneFormatado"]
    user.ramalUsp = @data["ramalUsp"]

    user.save

    id = user.id

    @vinculo = @data["vinculo"]

    @vinculo.each do |v|

      vinculoexiste = TipoVinculo.where(:usuario_id => id, :tipoVinculo => v["tipoVinculo"])

      if vinculoexiste.empty?
        tipoVinc = TipoVinculo.new
      else
        tipoVinc = TipoVinculo.find_by(:usuario_id => id, :tipoVinculo => v["tipoVinculo"] )
      end

      tipoVinc.codigoSetor = v["codigoSetor"]
      tipoVinc.nomeAbreviadSetor = v["nomeAbreviadSetor"]
      tipoVinc.nomeSetor = v["nomeSetor"]
      tipoVinc.codigoUnidade = v["codigoUnidade"]
      tipoVinc.siglaUnidade = v["siglaUnidade"]
      tipoVinc.nomeUnidade = v["nomeUnidade"]
      tipoVinc.nomeVinculo = v["nomeVinculo"]
      tipoVinc.nomeAbreviadoFuncao = v["nomeAbreviadoFuncao"]
      tipoVinc.tipoVinculo = v["tipoVinculo"]
      tipoVinc.usuario_id = id

      tipoVinc.save!

    end

    return loginUsuario

  end

  def destroy
    addlog("Saiu do sistema")
    log_out
    redirect_to colecao_index_path
  end


end
