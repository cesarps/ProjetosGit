class TagsController < ApplicationController
  def index
    @tags = Tag.all.order('album_id')
  end
end
