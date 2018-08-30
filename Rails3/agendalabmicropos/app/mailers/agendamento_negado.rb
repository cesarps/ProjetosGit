class AgendamentoNegado < ActionMailer::Base
  default :from => "naoresponder@icb.usp.br"

  def agendamento_negado(event)
      @event = event


      mail(:to => @event.u_email, :subject => 'Agendamento negado')
  end
end
