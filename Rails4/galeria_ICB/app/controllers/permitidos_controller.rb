class PermitidosController < ApplicationController

  before_action :set_permitido, only: [:show, :edit, :update, :destroy]

  before_filter 'autenticado?'

  # GET /permitidos
  # GET /permitidos.json
  def index
    @permitidos = Permitido.all
  end

  # GET /permitidos/1
  # GET /permitidos/1.json
  def show
  end

  # GET /permitidos/new
  def new
    @permitido = Permitido.new
  end

  # GET /permitidos/1/edit
  def edit
  end

  # POST /permitidos
  # POST /permitidos.json
  def create
    @permitido = Permitido.new(permitido_params)

    respond_to do |format|
      if @permitido.save
        addlog("Deu permissão a um usuário")
        format.html { redirect_to @permitido, notice: 'Permissão criada com sucesso.' }
        format.json { render :show, status: :created, location: @permitido }
      else
        format.html { render :new }
        format.json { render json: @permitido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permitidos/1
  # PATCH/PUT /permitidos/1.json
  def update
    respond_to do |format|
      if @permitido.update(permitido_params)
        addlog("Atualizou a permissão de um usuário")
        format.html { redirect_to @permitido, notice: 'Permissão atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @permitido }
      else
        format.html { render :edit }
        format.json { render json: @permitido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permitidos/1
  # DELETE /permitidos/1.json
  def destroy
    @permitido.destroy
    addlog("Negou permissão de um usuário")
    respond_to do |format|
      format.html { redirect_to permitidos_url, notice: 'Permissão apagada com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permitido
      @permitido = Permitido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitido_params
      params.require(:permitido).permit(:usuario_id, :perfil_id)
    end
end
