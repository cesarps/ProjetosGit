class PerfilsController < ApplicationController

  before_action :set_perfil, only: [:show, :edit, :update]
  before_filter 'autenticado?'          

  # GET /perfils
  # GET /perfils.json
  def index
    @perfils = Perfil.all
  end

  # GET /perfils/1
  # GET /perfils/1.json
  def show
  end

  # GET /perfils/new
  def new
    @perfil = Perfil.new
  end

  # GET /perfils/1/edit
  def edit
  end

  # POST /perfils
  # POST /perfils.json
  def create
    @perfil = Perfil.new(perfil_params)

    respond_to do |format|
      if @perfil.save
        addlog("Criou um novo perfil")
        format.html { redirect_to @perfil, notice: 'Perfil foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @perfil }
      else
        format.html { render :new }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfils/1
  # PATCH/PUT /perfils/1.json
  def update
    respond_to do |format|
      if @perfil.update(perfil_params)
        addlog("Atualizou um perfil")
        format.html { redirect_to @perfil, notice: 'Perfil foi atualizado com sucesso' }
        format.json { render :show, status: :ok, location: @perfil }
      else
        format.html { render :edit }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil
      @perfil = Perfil.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perfil_params
      params.require(:perfil).permit(:tipo)
    end
end
