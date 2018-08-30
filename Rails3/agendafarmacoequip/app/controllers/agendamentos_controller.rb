class AgendamentosController < ApplicationController
  # GET /agendamentos
  # GET /agendamentos.xml

  #Cadastro dos agendamentos, depende do registro de eventos
  def index
    @agendamentos = Agendamento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendamentos }
    end
  end

  # GET /agendamentos/1
  # GET /agendamentos/1.xml
  def show


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agendamento }
    end
  end

  # GET /agendamentos/new
  # GET /agendamentos/new.xml
  def new
    @agendamento = Agendamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agendamento }
    end
  end

  # GET /agendamentos/1/edit
  def edit
    @agendamento = Agendamento.find(params[:id])
  end

  # POST /agendamentos
  # POST /agendamentos.xml
  def create
    @agendamento = Agendamento.new(params[:agendamento])

    respond_to do |format|
      if @agendamento.save
        format.html { redirect_to(@agendamento, :notice => 'Agendamento was successfully created.') }
        format.xml  { render :xml => @agendamento, :status => :created, :location => @agendamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agendamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agendamentos/1
  # PUT /agendamentos/1.xml
  def update
    @agendamento = Agendamento.find(params[:id])

    respond_to do |format|
      if @agendamento.update_attributes(params[:agendamento])
        format.html { redirect_to(@agendamento, :notice => 'Agendamento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agendamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agendamentos/1
  # DELETE /agendamentos/1.xml
  def destroy
    @agendamento = Agendamento.find(params[:id])
    @agendamento.destroy

    respond_to do |format|
      #format.html { redirect_to(agendamentos_url) }
      if usuario_signed_in?
        format.html { redirect_to(index_event_path) }
      elsif admin_signed_in?
        format.html { redirect_to(index_event_admin_path) }
      end

      format.xml  { head :ok }
    end
  end
end
