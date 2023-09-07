class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)

    # @q = Pigeon.ransack(params[:q])
    # puts params[:q]
    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      tag_name = params[:q][:tags_name_cont_any]
      tag_name.each do |tag|
        @pigeons = @pigeons.tagged_with(names: tag_name)
      end
    end

    if params[:query].present?
      sql_subquery = "title ILIKE :query OR description ILIKE :query"
      @pigeons = @pigeons.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

end
