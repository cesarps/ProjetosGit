class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  #before_filter :authenticate_usuario!

  def tipodescricao
    @tipo = Tipo.find(params[:tipo_id])

    respond_to do |format|
      format.js
    end
  end


  def index

    @u = current_usuario

    if @u != nil
      @events = Event.scoped(:select => ["events.id, tipos.nome, tipos.cor, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at,  concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title "],:joins => ["events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id "], :conditions => [" usuarios.email = ? ", @u.email], :order => [" tipos.nome, ag.data_inicio, ag.hora_inicio"])
    else
      @events = Event.scoped(:select => ["events.id, tipos.nome, tipos.cor, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at,  concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title "],:joins => ["events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id "], :conditions => [" usuarios.email = 'farodrigues@icb.usp.br' "], :order => [" tipos.nome, ag.data_inicio, ag.hora_inicio"])
    end

    @event_tipo = @events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  def index_event
    @events = Event.all

    respond_to do |format|
      format.html
      format.xml { render :xml => @events }
      format.js { render :json => @events }
    end
  end

  def show_ags
    @event = Event.find(params[:id])
  end


  def newindex

    @u = current_usuario
    @events = Event.scoped(select: ["events.*, ag.inicio, ag.fim, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title, u.nome_completo "]).joins("events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id inner join usuarios u  on u.email = events.u_email").where("usuarios.email = ? and  ag.data_inicio >= ?",  @u.email, Date.today).order ("tipos.nome, ag.data_inicio, ag.hora_inicio")


    @event_tipo = @events

    respond_to do |format|
      format.html
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end

  end

  # GET /events/1
  # GET /events/1.xml
  def show                                       # mostra os eventos
    @event = Event.find(params[:id],:order => ["tipo_id"])
    #@agendamento = Agendamento.find(:all, :conditions => params[:event_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  def show_one                                   # mostra um unico evento
                                                 # mostra um unico agendamento
    @event = Event.find(:all)
    respond_to do |format|
      format.html # show_one.html.erb
      format.xml  { render :xml => "show_one" }
      format.js { render :json => "show_one" }
    end
  end

  def ver_dia
    @tipo = Tipo.find(:all)
    respond_to do |format|
      format.html # ver_dia.html.erb
      format.xml  { render :xml => "ver_dia" }
      format.js { render :json => "ver_dia" }
    end
  end

  def monta_relatorio

    if params[:dia].blank? or params[:dia]["dia(1i)"].blank?
      @data =  nil
    else
      if params[:dia]["dia(2i)"].blank?
        @data = Date.new(y=params[:dia]["dia(1i)"].to_i)
      else
        if params[:dia]["dia(3i)"].blank?
          @data = Date.new(y=params[:dia]["dia(1i)"].to_i, m=params[:dia]["dia(2i)"].to_i)
        else
          @data = Date.new(y=params[:dia]["dia(1i)"].to_i, m=params[:dia]["dia(2i)"].to_i, d=params[:dia]["dia(3i)"].to_i)
        end
      end
    end

    if params[:sala].blank?
    	@tipo = nil
    else
    	@tipo = params[:sala]
    end

    @result = Event.find_by_sql(["select agendamentos.data_inicio, events.id, events.starts_at, events.ends_at, events.title, events.tipo_id, events.regpara, usuarios.nome_completo , tipos.nome as tiponome, events.description, events.u_email   from events inner join agendamentos on events.id = agendamentos.event_id  inner  join usuarios on events.u_email = usuarios.email inner join tipos on events.tipo_id = tipos.id where events.tipo_id = ? and agendamentos.data_inicio = ?",@tipo, @data])


    respond_to do |format|
      format.html # monta_relatorio.html.erb
      format.xml { render :xml => @events }
      format.js  { render :json => @events }
    end

  end

  # GET /events/new
  # GET /events/new.xml

  def pre_form

  end

  def new
    @event = Event.new
    @tipos = Tipo.all
    @tot_tipos = @tipos.count
    @user = current_usuario

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml

  #Funçao para criaçao de registros de eventos e de agendamento
  def create
    # cria um novo evento e todos os seus agendamentos

    @event = Event.new(params[:event])

    # acha todos os tipos
    tipo = Tipo.find(:all)
    tipo.each do |t|
      if t.id == @event.tipo_id
      	if t.confirmacao == true   # marca o campo confirmação como true
        	@event.pendente = true
      	else
        	@event.pendente = false  # marca o campo confirmação como false
      	end
      end
    end


      # redireciona para a página correta
      respond_to do |format|
        if @event.save
          @usuario_logado = current_usuario
          @admin_logado = current_admin
          @usuario_logado ? @usuario_logado : @admin_logado

          @inicio=Date.parse(@event.starts_at.to_s)    # cria uma string para a data e hora do inicio do evento
          @fim=Date.parse(@event.ends_at.to_s)

          @horainicio = @event.starts_at.to_datetime.strftime("%H:%M")
          @horafim = @event.ends_at.to_datetime.strftime("%H:%M")

          # cria uma string para a data e hora do inicio do evento
          # cria uma string para a data e hora do fim do evento
          if @inicio == @fim                           # compara as strings para saber se o evento tem um ou mais dias
            # passa os parametros do agendamento e os salva no banco
            @agendamento = Agendamento.new
            @agendamento.data_inicio = @event.starts_at
            @agendamento.data_fim = @event.ends_at
            @agendamento.hora_inicio = @event.starts_at
            @agendamento.hora_fim = @event.ends_at
            @agendamento.event_id = @event.id
            @agendamento.tipo_id = @event.tipo_id
            @agendamento.inicio = @horainicio
            @agendamento.fim = @horafim
            @agendamento.save
          else
            @inicio.upto(@fim) do |int|   #Caso seja um evento com mais de um agendamento
              #Faz um rotina de repetição para salvar todos os agendamentos
              #no intervalo determinado no evento
              #Considerando os dias da semana

              # marca os dias da semana do evento e salva no banco
              case int.wday
                when 0
                  if @event.domingo == true              # passa os parametros do agendamento e os salva no banco
                    @agendamento = Agendamento.new
                    @agendamento.data_inicio = int
                    @agendamento.data_fim = int
                    @agendamento.hora_inicio = @event.starts_at
                    @agendamento.hora_fim = @event.ends_at
                    @agendamento.event_id = @event.id
                    @agendamento.tipo_id = @event.tipo_id
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
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
                    @agendamento.inicio = @horainicio
                    @agendamento.fim = @horafim
                    @agendamento.save
                  end
              end
            end
          end

          # Chama a funçao de validação, caso seja um evento conflitante destroy o que acabou de ser criado.
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
        if @a > 0
          format.html { render :action => "erro" }
        else
          if @event.pendente == true
            format.html { redirect_to(@event, :notice => 'Evento criado com sucesso. Por favor aguarde o evento ser confirmado pelo administrador da sala.') }
            format.xml  { render :xml => @event, :status => :created, :location => @event }
          else
            format.html { redirect_to(@event, :notice => 'Evento criado com sucesso.') }
            format.xml  { render :xml => @event, :status => :created, :location => @event }
          end
        end
        else
          format.html { render :action => "new" }
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
    #Para atualizaçao do evento tem que continuar respeitando a regra de salvar baseado nos dias da semana
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])

        # acha todos os tipos
        tipo = Tipo.find(:all)
        tipo.each do |t|
          if t.id == @event.tipo_id
            if t.confirmacao == true   # marca o campo confirmação como true
              @event.pendente = true
            else
              @event.pendente = false  # marca o campo confirmação como false
            end
          end
        end

        @agendamento = Agendamento.where(:event_id => @event.id)
        @agendamento.each do |ag|
          ag.destroy
        end
        @inicio=Date.parse(@event.starts_at.to_s)
        @fim=Date.parse(@event.ends_at.to_s)

        @horainicio = @event.starts_at.to_datetime.strftime("%H:%M")
        @horafim = @event.ends_at.to_datetime.strftime("%H:%M")

        if @inicio == @fim
          @agendamento = Agendamento.new
          @agendamento.data_inicio = @event.starts_at
          @agendamento.data_fim = @event.ends_at
          @agendamento.hora_inicio = @event.starts_at
          @agendamento.hora_fim = @event.ends_at
          @agendamento.event_id = @event.id
          @agendamento.tipo_id = @event.tipo_id
          @agendamento.inicio = @horainicio
          @agendamento.fim = @horafim
          @agendamento.save
        else
          @inicio.upto(@fim) do |int|

            case int.wday

              # marca os dias da semana do evento e salva no banco
              when 0
                if @event.domingo == true
                  @agendamento = Agendamento.new
                  @agendamento.data_inicio = int
                  @agendamento.data_fim = int
                  @agendamento.hora_inicio = @event.starts_at
                  @agendamento.hora_fim = @event.ends_at
                  @agendamento.event_id = @event.id
                  @agendamento.tipo_id = @event.tipo_id
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
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
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
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
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
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
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
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
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
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
                  @agendamento.inicio = @horainicio
                  @agendamento.fim = @horafim
                  @agendamento.save
                end
            end
          end
        end

        #Chama a funçao de validação caso seja um evento conflitante destroy o que acabou de ser criado.
        valida

        format.html { redirect_to(@event, :notice => 'Evento alterado com sucesso.') }
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

  def redireciona
    redirect_to(:controller => 'calendar', :action => 'index')
  end

# DELETE /events/1
# DELETE /events/1.xml
  def destroy
  # deleta o agendamento e o evento

=begin
    @agendamento = Agendamento.where(:event_id => params[:id])
    @agendamento.each do |ag|
      ag.destroy
    end
=end

    @event = Event.find(params[:id])
    @event.destroy

    #esta carregando essas variaveis novamente para redirecionar para a tela newindex (como a tela precisava dessas variaveis... alimento elas aqui)
    @u = current_usuario
    @a = current_admin
    #corrigido em 16/08/13
    #@events = Event.scoped(:select => ["events.*, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, tipos.nome"],:joins => ["events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id "], :conditions => ["usuarios.email = ? and ag.data_inicio >= ?", @u.email, Date.current], :order => [" tipos.nome, ag.data_inicio, ag.hora_inicio"])
    #@events = Event.scoped(:select => ["events.*, ag.inicio, ag.fim, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, concat(ag.inicio, ' ' , ag.fim, ' - ',  tipos.nome) as title "],:joins => ["events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id "], :conditions => ["usuarios.email = ? and ag.data_inicio >= ?", @u.email, Date.current], :order => [" tipos.nome, ag.data_inicio, ag.hora_inicio"])

    if usuario_signed_in?
      @events = Event.scoped(:select => ["events.*, ag.inicio, ag.fim, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title, u.nome_completo "]).joins("events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id inner join usuarios u  on u.email = events.u_email ").where("usuarios.email = ? and  ag.data_inicio >= ?",  @u.email, Date.current).order(" tipos.nome, ag.data_inicio, ag.hora_inicio")
    elsif admin_signed_in?
      @events = Event.scoped(:select => ["events.*, ag.inicio, ag.fim, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title, u.nome_completo "]).joins("events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id inner join usuarios u  on u.email = events.u_email ").where("ag.data_inicio >= ?",  Date.current).order(" tipos.nome, ag.data_inicio, ag.hora_inicio")

    end


    @event_tipo = @events

    respond_to do |format|
      if usuario_signed_in?
        format.html { redirect_to index_event_path}
      elsif admin_signed_in?
        format.html {  redirect_to index_event_admin_path }
      end
      format.xml  { head :ok }
    end
  end
end
