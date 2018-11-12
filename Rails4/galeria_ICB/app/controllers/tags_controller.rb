class TagsController < ApplicationController


PER_PAGE = 400
  def index
    #@tags = Tag.all.order('album_id').page(params[:page]).per(PER_PAGE)
    @tags = Tag.select('nome').order('id desc').uniq.page(params[:page]).per(PER_PAGE)
  end
end
