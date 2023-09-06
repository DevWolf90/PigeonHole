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

  def create
    @pigeon = Pigeon.new(pigeon_params)
    @pigeon.summary = "api"
    @pigeon.length = "api"
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :media_type)
  end
end
