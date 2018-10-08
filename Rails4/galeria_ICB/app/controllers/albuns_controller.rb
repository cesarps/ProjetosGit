class AlbunsController < ApplicationController
  before_filter 'check_logged'
  before_action :set_album, only: [:show, :edit, :update, :destroy, :escolher_capa]


  # GET /albuns
  # GET /albuns.json




  def escolher_capa
    set_album
  end

  def definir_capa
    set_album
    @album.capa = params[:capa]
    if params[:capa].nil?
      redirect_to escolhe_capa_path, notice:  "Escolha uma capa para seu album"
    else
      @album.save!
      @capa = @album.capa
      @foto = Foto.find(@capa)
    end
  end


  def index
    @albuns = Album.all.order("data_evento desc")
  end

  # GET /albuns/1
  # GET /albuns/1.json
  def show
    @fotos = @album.fotos.all
  end

  # GET /albuns/new
  def new
    @album = Album.new
    @album.tags.build if @album.tags.empty?
    @album.fotos.build  if @album.fotos.empty?


  end

  # GET /albuns/1/edit
  def edit

    @fotos = @album.fotos.all
    @total = @album.fotos.count
    @album.tags.build if @album.tags.empty?
    @album.fotos.build  if @album.fotos.empty?

  end

  # POST /albuns
  # POST /albuns.json
  def create
   # default_index = params[:foto][:capa]
   # params[:album][:fotos_attributes][:default_index][:default] = true
    @album = Album.new(album_params)
    respond_to do |format|
      if @album.save
        params[:fotos]['arquivo'].each do |a|
          @foto = @album.fotos.create!(:arquivo => a, :album_id => @album.id)
        end

        format.html { redirect_to @album, notice: 'Album criado com sucesso.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
      # aqui vai o código do concluir_legenda que vai gerar registros vazios de legendas


    end
  end

  # PATCH/PUT /albuns/1
  # PATCH/PUT /albuns/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
       @capa = @album.capa
       repete_legenda
        format.html { redirect_to @album, notice: 'Album atualizado com sucesso .' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albuns/1
  # DELETE /albuns/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albuns_url, notice: 'Album apagado com sucesso.' }
      format.json { head :no_content }
    end
  end



  def repete_legenda
    valor_legenda = ""
    @total = @album.fotos.count


    @album.fotos.each do |f|
      if f.subtitle != "" and valor_legenda == ""
        valor_legenda = f.subtitle
      end
    end



    @album.fotos.each do |f|
      if f.subtitle.blank? or f.subtitle.nil?
        f.subtitle = valor_legenda
        f.save!
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
        params.require(:album).permit(:data_evento, :nome_evento_assunto, :departamento_id, :nome_fotografo, :endereco, :categoria_id, :capa,  tags_attributes:[:id,:nome, :_destroy], fotos_attributes:[:id, :arquivo, :subtitle,:uniq_subtitle,  :_destroy], legendas_attributes:[:id, :foto_id,:album_id, :texto])
    end
end
