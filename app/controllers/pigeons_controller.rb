class PigeonsController < ApplicationController
  before_action :set_pigeon, only: [show]
  def index
    @pigeons = Pigeon.all
  end

  def show
  end

  private

  def set_pigeon
    @pigeon = Pigeon.find(params[:id])
  end
end
