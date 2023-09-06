class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)

  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :media_type)
  end
end
