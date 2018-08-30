class AdminEventController < ApplicationController
  # GET /events
  # GET /events.xml
  before_filter :authenticate_admin!

  def index
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    #@event_tipo=Event.find_by_sql("select events.*, tipos.nome from events left join tipos on tipo_id= tipos.id where events.tipo_id = tipos.id")
    #@events = Event.scoped
    @events = Event.scoped(:select => ["events.*, tipos.nome"],:joins => ["events left join tipos on tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id where events.tipo_id = tipos.id"])
    #@events = @events.after(params['start']) if (params['start'])
    #@events = @events.before(params['end']) if (params['end'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    @agendamento = Agendamento.find(:all, :conditions => params[:event_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  def show_one
    # mostra um unico agendamento
    @event = Event.find(:all)
    respond_to do |format|
      format.html # show_one.html.erb
      format.xml  { render :xml => "show_one" }
      format.js { render :json => "show_one" }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def aceita
    @e = Event.find(params[:id])

    Confirmado.confirmado(@e).deliver
    @e.pendente = 0
    @e.save

    redirect_to :controller => 'admin', :action => 'show', :id => @e.id
  end

  def rejeita
    event = Event.find(params[:id])

    AgendamentoNegado.agendamento_negado(event).deliver

    event.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'tipos', :action => 'index') }
      format.xml  { head :ok }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml

  #Fun�ao para cria�ao de registros de eventos e de agendamento
  def create
    # cria um novo evento e todos os seus agendamentos

    @event = Event.new(params[:event])

    # acha todos os tipos
    tipo = Tipo.find(:all)
    tipo.each do |t|
      if t.confirmacao == true   # marca o campo confirma��o como true
        @event.pendente = true
      else
        @event.pendente = false  # marca o campo confirma��o como false
      end

    end

    respond_to do |format|

    if @event.save
      @inicio=Date.parse(@event.starts_at.to_s)   # cria uma string para a data e hora do inicio do evento
      @fim=Date.parse(@event.ends_at.to_s)        # cria uma string para a data e hora do fim do evento
      if @inicio == @fim                          # compara as strings para saber se o evento tem um ou mais dias
                                                  # passa os parametros do agendamento e os salva no banco
        @agendamento = Agendamento.new
        @agendamento.data_inicio = @event.starts_at
        @agendamento.data_fim = @event.ends_at
        @agendamento.hora_inicio = @event.starts_at
        @agendamento.hora_fim = @event.ends_at
        @agendamento.event_id = @event.id
        @agendamento.tipo_id = @event.tipo_id
        @agendamento.save
      else
        @inicio.upto(@fim) do |int|   #Caso seja um evento com mais de um agendamento
                                      #Faz um rotina de repeti��o para salvar todos os agendamentos
                                      #no intervalo determinado no evento
                                      #Considerando os dias da semana
          case int.wday
            when 0
              if @event.domingo == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 1
              if @event.segunda == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 2
              if @event.terca == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 3
              if @event.quarta == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 4
              if @event.quinta == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 5
              if @event.sexta == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
            when 6
              if @event.sabado == true
                @agendamento = Agendamento.new
                @agendamento.data_inicio = int
                @agendamento.data_fim = int
                @agendamento.hora_inicio = @event.starts_at
                @agendamento.hora_fim = @event.ends_at
                @agendamento.event_id = @event.id
                @agendamento.tipo_id = @event.tipo_id
                @agendamento.save
              end
          end
        end
      end

      # Chama a fun�ao de valida��o, caso seja um evento conflitante destroy o que acabou de ser criado.
      valida

      # Envia email de confirmacao caso o evento fique pendente
      if @event.pendente == true
        @tipo = Tipo.find(:all)
        @tipo.each do |tipo|
          if tipo.id == @event.tipo_id
            AgPendente.email_agendamento(@event, tipo).deliver
          end
        end
      end

      # redireciona para a p�gina correta


        if @a > 0
          format.html { render :action => "erro" }
        else
          format.html { redirect_to(@event, :notice => 'Evento criado com sucesso.') }
          format.xml  { render :xml => @event, :status => :created, :location => @event }
        end

      end
    end
  end



  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    #Para atualiza�ao do evento tem que continuar respeitando a regra de salvar baseado nos dias da semana
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        @agendamento = Agendamento.where(:event_id => @event.id)
        @agendamento.each do |ag|
          ag.destroy
        end
        @inicio=Date.parse(@event.starts_at.to_s)
        @fim=Date.parse(@event.ends_at.to_s)
        if @inicio == @fim
          @agendamento = Agendamento.new
          @agendamento.data_inicio = @event.starts_at
          @agendamento.data_fim = @event.ends_at
          @agendamento.hora_inicio = @event.starts_at
          @agendamento.hora_fim = @event.ends_at
          @agendamento.event_id = @event.id
          @agendamento.save
        else
          @inicio.upto(@fim) do |int|

            case int.wday
              when 0
                if @event.domingo == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 1
                if @event.segunda == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 2
                if @event.terca == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 3
                if @event.quarta == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 4
                if @event.quinta == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 5
                if @event.sexta == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
              when 6
                if @event.sabado == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.save
                end
            end
          end
        end

        #Chama a fun�ao de valida��o caso seja um evento conflitante destroy o que acabou de ser criado.

        format.html { redirect_to(@event, :notice => 'Evento criado com sucesso.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def erro
    respond_to do |format|
      format.html { redirect_to(erro_criacao)}
    end
  end



  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @e = Event.find(params[:id])
    @e.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => 'tipos', :action => 'index') }
      format.xml  { head :ok }
    end
  end
end