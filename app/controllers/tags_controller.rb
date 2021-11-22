class TagsController < ApplicationController
 def show
  @tag = Tag.find_by(name: params[:id])
  @reviews = @tag.reviews
 end
end
