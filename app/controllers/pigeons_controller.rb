
class PigeonsController < ApplicationController
  def index
    @pigeons = Pigeon.all
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)

    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      selected_tags = params[:q][:tags_name_cont_any]

      selected_tags.each do |tag|
        @pigeons = @pigeons.tagged_with(names: tag)
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

  def new
    @pigeon = Pigeon.new
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)
    @chat = Chat.where(sender: current_user).where(recipient: @pigeon.recipient)
    if @chat.nil?
      @chat = Chat.create(sender: current_user, recipient: @pigeon.recipient)
    end

    @message = Message.new(user: current_user, chat: @chat)
    # if @pigeon.link_to_content.include?("youtu")

    #   url = "https://www.googleapis.com/youtube/v3/videos?id=#{get_yt_id(@pigeon.link_to_content)}=#{ENV["GOOGLE_API_KEY"]}
    #   &fields=items(id,snippet(title,description),contentDetails(duration))&part=snippet,contentDetails"
    #   video_serialized = URI.open(url).read
    #   video_data = JSON.parse(video_serialized)
    #   exp = get_yt_id("https://www.youtube.com/watch?v=Z_6qzBlWLxQ&t=5016s")
    #   raise
    #   @pigeon.summary = "api"
    #   @pigeon.length = "api"
    # end
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :media_type, :description)
  end

  # def get_yt_id(url)
  #   @url= url
  #   youtube_formats = [
  #     %r(https?://youtu\.be/(.+)),
  #     %r(https?://www\.youtube\.com/watch\?v=(.*?)(&|#|$)),
  #     %r(https?://www\.youtube\.com/embed/(.*?)(\?|$)),
  #     %r(https?://www\.youtube\.com/v/(.*?)(#|\?|$)),
  #     %r(https?://www\.youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b)
  #   ]
  #   @url.strip!
  #   youtube_formats.find { |format| @url =~ format } && $1
  #    return $1

  # end
end
