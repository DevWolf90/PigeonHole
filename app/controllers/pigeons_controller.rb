
class PigeonsController < ApplicationController
  before_action :set_pigeons, only: %i[index show]

  def index
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
    @mediatypes = ["article", "book", "movie", "playlist", "podcast", "song", "video", "other"]


    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      selected_tags = params[:q][:tags_name_cont_any]
      @foundpigeons = Pigeon.tagged_with(:names => selected_tags, match: :all)

      selected_tags.each do |tag|
        @pigeons = @pigeons.tagged_with(names: tag)
      end

    end

    if params[:q].present? && params[:q][:media_type].present?
      selected_media_types = params[:q][:media_type]
      # @foundpigeons = @pigeons.where(media_type: selected_media_types)
      selected_media_types.each do |mt|
        @pigeons = @pigeons.where(media_type: mt)
      end

    end

    if params[:query].present?
      sql_subquery = "title ILIKE :query OR description ILIKE :query"
      @pigeons = @pigeons.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def toggle_read #toggle read on show page
    @pigeon = Pigeon.find(params[:id])
    @pigeon.read = !@pigeon.read
    @pigeon.save
    redirect_to pigeon_path(@pigeon)
  end

  def mark_read # marks read after opening
    @pigeon = Pigeon.find(params[:id])
    if !@pigeon.read
      @pigeon.read = true
      @pigeon.save
    end
    redirect_to pigeon_path(@pigeon)
  end

  def link_read # marks read on index page without redirecting to show page
    @pigeon = Pigeon.find(params[:id])
    @pigeon.read = !@pigeon.read
    @pigeon.save
    redirect_to pigeons_path
  end

  def toggle_favourite # toggles favourite on show page
    @pigeon = Pigeon.find(params[:id])
    @pigeon.favourite = !@pigeon.favourite
    @pigeon.save
    redirect_to pigeon_path(@pigeon)
  end

  def link_favourite # toggles favourite on index page without redirecting to show page
    @pigeon = Pigeon.find(params[:id])
    @pigeon.favourite = !@pigeon.favourite
    @pigeon.save
    redirect_to pigeons_path
  end

  def add_to_reply # adds to reply later and redirects to homepage
    @pigeon = Pigeon.find(params[:id])
    @pigeon.reply_later = true
    @pigeon.save
    redirect_to root_path
  end

  def show
    @pigeon = @pigeons.find(params[:id])
  end

  def new
    @user = User.new
    @pigeon = Pigeon.new
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
  end

  def edit
    @pigeon = Pigeon.find(params[:id])
  end

  def update
    @pigeon = Pigeon.find(params[:id])
    if @pigeon.update(pigeon_params)
      redirect_to pigeons_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    # @pigeons = Pigeon.all
    @pigeon = Pigeon.new(pigeon_params)
    @pigeon.chat = @chat
    # custom_tags = []
    @chat = Chat.where(sender: current_user).where(recipient: @pigeon.recipient)
    if @chat.nil?
      @chat = Chat.where(sender: @pigeon.recipient).where(recipient: current_user)
    end
    if @chat.nil?
      @chat = Chat.create(sender: current_user, recipient: @pigeon.recipient)
    end
    selected_tags = params[:pigeon][:tags]
    unless selected_tags.nil?
    selected_tags.each do |tag_name|
      tag = Gutentag::Tag.find_by(name: tag_name)
      @pigeon.tag_names << tag_name if tag.present? && !tag_name.empty?
      end
    end

    custom_tags = params[:pigeon][:custom_tags]
    unless custom_tags.nil?
      if custom_tags.include?(",")
        custom_tags.split(",").each do |tag|
        @pigeon.tag_names << tag.strip.downcase unless tag.strip.empty?
        end
      else
        @pigeon.tag_names << custom_tags.strip.downcase
      end
    end

    recipient_user = User.find(rand(11..15))
    @pigeon.recipient = recipient_user if recipient_user.present?
    raise
    @pigeon.date = Date.today
    @pigeon.save
    @message = Message.new(user_id: current_user.id, chat_id: @chat.id)
    @message.content = @pigeon.description
    @message.save

    redirect_to pigeons_path(@pigeons)
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

  def destroy
    @pigeon = Pigeon.find(params[:id])
    @pigeon.destroy
    redirect_to pigeons_path, notice: "Pigeon was successfully deleted!", status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :description, :media_type, :tags, :custom_tags)
  end

  def set_pigeons
    @pigeons = Pigeon.where(recipient: current_user)
  end
end
