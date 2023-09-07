require "json"
require "open-uri"

class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)

    # @q = Pigeon.ransack(params[:q])
    # puts params[:q]
    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      tag_name = params[:q][:tags_name_cont_any]
      @pigeons = Pigeon.tagged_with(names: tag_name)
    else
      puts "No tags"
    end
    # @q = Pigeon.ransack(params[:q])
    # @tags = @q.result.includes(:pigeons).tag_name(params[:tag_names])
    if params[:query].present?
      sql_subquery = "title ILIKE :query OR description ILIKE :query"
      @pigeons = @pigeons.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @pigeon = Pigeon.find(params[:id])
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)
    url = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=#{ENV["GOOGLE_API_KEY"]}
    &fields=items(id,snippet(title,description),contentDetails(duration))&part=snippet,contentDetails"
    video_serialized = URI.open(url).read
    video_data = JSON.parse(video_serialized)
    raise
    @pigeon.summary = "api"
    @pigeon.length = "api"
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :media_type)
  end
end
