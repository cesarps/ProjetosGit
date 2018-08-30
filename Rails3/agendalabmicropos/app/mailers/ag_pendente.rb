class AgPendente < ActionMailer::Base
  default :from => "naoresponder@icb.usp.br"

  def email_agendamento(event, tipo)
    @event = event
    @tipo = tipo

    mail(:to => @tipo.email, :subject => 'Agendamento')
  end
end
