class Confirmado < ActionMailer::Base
  default :from => "naoresponder@icb.usp.br"

  def confirmado(event)
    @event = event

    mail(:to => @event.u_email, :subject => 'Agendamento confirmado')
  end
end
