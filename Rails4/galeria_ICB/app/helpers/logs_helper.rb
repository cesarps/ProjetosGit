module LogsHelper

  def addlog(acao)

    @log  = Log.new

    @log.acao = acao
    @log.usuario_id = current_user.id
    @log.ip = request.remote_addr

    @log.save!

  end

end
