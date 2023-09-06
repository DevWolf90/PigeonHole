class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
    # @q = Pigeon.ransack(params[:q])
    # @tags = @q.result.includes(:pigeons).tag_name(params[:tag_names])
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

  # def add_to_favourites
  #   @pigeon = Pigeon.find(params[:id])
  #   @pigeon.update(favourite: true)
  # end
end
