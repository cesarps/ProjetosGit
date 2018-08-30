class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def show                 # permite o admin ver todos os eventos marcados
    @event = Event.find(:all)
    @agendamento = Agendamento.find(:all, :conditions => params[:event_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  def ver_usuarios          # pagina com todos os usuarios do sistema (vista pelo admin)
    @usuario = Usuario.find(:all)

  end

  def permissoes            # configura permissoes de usuario

    @user = Usuario.find(params[:id])
    @tipo = Tipo.find(:all)

  end

  def newindex

    @a = current_admin
    @events = Event.scoped(select: ["events.*, ag.inicio, ag.fim, tipos.nome, concat(ag.data_inicio, ' ', ag.hora_inicio) as starts_at, concat(ag.data_fim, ' ', ag.hora_fim) as ends_at, title, u.nome_completo "]).joins("events left join tipos on events.tipo_id= tipos.id inner join tipo_usuarios on tipos.id = tipo_usuarios.tipo_id inner join usuarios on tipo_usuarios.usuario_id = usuarios.id inner join agendamentos ag on ag.event_id = events.id inner join usuarios u  on u.email = events.u_email").where(" ag.data_inicio >= ?",  Date.today).order ("tipos.nome, ag.data_inicio, ag.hora_inicio")

    @event_tipo = @events

    respond_to do |format|
      format.html
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

end