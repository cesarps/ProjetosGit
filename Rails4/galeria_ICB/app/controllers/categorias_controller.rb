class CategoriasController < ApplicationController


  before_action :set_categoria, only: [:show, :edit, :update, :destroy]
  before_filter 'autenticado?'

  # GET /categorias
  # GET /categorias.json
  def index
    @categorias = Categoria.all
  end

  # GET /categorias/1
  # GET /categorias/1.json
  def show
  end

  # GET /categorias/new
  def new
    @categoria = Categoria.new
  end

  # GET /categorias/1/edit
  def edit
  end

  # POST /categorias
  # POST /categorias.json
  def create
    @categoria = Categoria.new(categoria_params)

    respond_to do |format|
      if @categoria.save
        addlog("Categoria criada")
        format.html { redirect_to @categoria, notice: 'Categoria criada com sucesso.' }
        format.json { render :show, status: :created, location: @categoria }
      else
        format.html { render :new }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorias/1
  # PATCH/PUT /categorias/1.json
  def update
    respond_to do |format|
      if @categoria.update(categoria_params)
        addlog("Categoria atualizada")
        format.html { redirect_to @categoria, notice: 'Categoriaatualziada com sucesso.' }
        format.json { render :show, status: :ok, location: @categoria }
      else
        format.html { render :edit }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.json
  def destroy
    @categoria.destroy
    addlog("Categoria apagada")
    respond_to do |format|
      format.html { redirect_to categorias_url, notice: 'Categoria apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoria_params
      params.require(:categoria).permit(:nome)
    end
end
