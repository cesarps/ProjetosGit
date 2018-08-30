class ApplicationController < ActionController::Base
  protect_from_forgery
  # got these tips from
  # http://lyconic.com/blog/2010/08/03/dry-up-your-ajax-code-with-the-jquery-rest-plugin
  before_filter :correct_safari_and_ie_accept_headers

  after_filter :set_xhr_flash

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end



  #Validação do cadastro de eventos para evitar conflitos de horários e salas
  #A funçao verifica e sinaliza o que deve ser eliminado outra funçao que mata os registros
  def valida
    print"validaaaaa"
    if @event.save
      @a = 0

      #busca ultimo agendamento,todos os eventos, todos os agendamentos exceto o ultimo
      #agen_novo = Agendamento.find(:last, :order => "updated_at")     # não esta trazendo a query certa...
      agen_novo = Agendamento.where("event_id in (?)", @event.id)         #compara com todos os agendamentos criados se tiver algum conflitando deve ser apagado
      @evento = Event.find(:last, :order => "updated_at")
      agendamentos = Agendamento.where("event_id not in (?)", @event.id)

      agen_novo.each do |agennew|
        agendamentos.each do |agen|
          print "agen.event_id = " + agen.event_id.to_s + "\n"
          print "evento.id = " + @evento.id.to_s + "\n"
          print "agen.novo = " + agennew.id.to_s + "\n"
          if agen.event_id != @evento.id
            print "@a = " + @a.to_s + "\n"

            #compara o tipo de agendamento(sala)
            if agennew.tipo_id == agen.tipo_id
              #compara os horários e verifica se há sobreposição

              if agennew.data_inicio == agen.data_inicio
                print "datainicio igual" + "\n"
                if agennew.hora_inicio >= agen.hora_inicio && agennew.hora_inicio <= agen.hora_fim
                  @a = @a + 1
                  print "@a depois do 1 if = " + @a.to_s + "\n"
                end

                if agennew.hora_fim <= agen.hora_fim && agennew.hora_fim >= agen.hora_inicio
                  @a = @a + 1
                  print "@a depois do 2 if = " + @a.to_s + "\n"
                end

                if agennew.hora_inicio <= agen.hora_inicio && agennew.hora_fim >= agen.hora_fim
                  @a = @a + 1
                  print "@a depois do 3 if = " + @a.to_s + "\n"
                end
              end
            end

          end

          # Destroi o evento se houver conflito
          if @a > 0
            print "Entrou aqui no @a"
            @evento.destroy
          end
        end
      end
    end
  end

end
