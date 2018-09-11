class ColecaoController < ApplicationController
  PER_PAGE = 12

  def index
    @album = Album.all.page(params[:page]).per(PER_PAGE)
    @tags = Tag.select('nome').order('id desc').uniq.limit(30)
  end

  def mostrar
    @album = Album.find(params[:id])
    @fotos = Foto.where(album_id: @album.id).where(categoria_id: 2)
  end




  def pesquisa
    busca = ""

    if params[:data_inicio] != "" and params[:data_fim] != ""
      busca = "data_evento between '" + params[:data_inicio] + "' and '" + params[:data_fim] + "'"		# busca pela data
    end

    if params[:nome_evento] != ""
      if busca != ""
        busca = busca + " and "
      end
      busca = busca + "nome_evento_assunto like '%" + params[:nome_evento] + "%'"				# busca pelo evento
    end

    if !params[:departamento_id].empty?
      if busca != ""
        busca = busca + " and "
      end
      busca = busca + " departamento_id = " + params[:departamento_id].to_s					# busca pelo departamento
    end

    if busca != ""
      @album = Album.find_by_sql("select * from albuns where " +  busca)
      if params[:legenda] != ""
        @album = Album.joins(:fotos).where("fotos.legenda like ? ", "%"+params[:legenda]+"%")			# busca pela legenda somente se ela for preenchida
        respond_to do |format|
          format.html
        end
      end
    elsif params[:legenda] != ""                                                                # somente params[:legenda]
        @album = Album.joins(:fotos).where("fotos.legenda like ? ", "%"+params[:legenda]+"%")			# busca pela legenda somente se ela for preenchida
        respond_to do |format|
          format.html
        end
    else
        redirect_to colecao_index_path
    end
  end




  def busca_tag
    @tags = Tag.where("nome like ?",'%' + params[:nome] + '%' ).order('album_id')
    valor = ''
    @tags.each do |tag|
      if valor != ''
        valor = valor + ','
      end
      valor = valor + tag.album_id.to_s
    end
    valor_sep = valor.split(',')
    @album_pesq = Album.where("id in (?)", valor_sep )
  end


end
