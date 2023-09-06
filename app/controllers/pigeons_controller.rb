class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
    @q = Pigeon.ransack(params[:q])

    if params[:iq] && params[:q][:tag_name_cont].present?
      @q.tag_names_cont(params[:q][:tag_names_cont])
    end
    @pigeons = @q.result(distinct:true)
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

end
