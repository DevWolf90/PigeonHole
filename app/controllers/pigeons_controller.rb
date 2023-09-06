class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
    @q = Pigeon.ransack(params[:q])
    puts params[:q]
    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      tag_name = params[:q][:tags_name_cont_any]
      @pigeons = Pigeon.tagged_with(names: tag_name)
    else
      puts "No tags"
    end
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

end
