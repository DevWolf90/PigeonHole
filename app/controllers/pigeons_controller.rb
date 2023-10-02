
class PigeonsController < ApplicationController
  before_action :set_pigeons, only: %i[index show]

  def index
    @alltags = Gutentag::Tag.names_for_scope(Pigeon.where(recipient: current_user))
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
      sql_subquery = "
        pigeons.title ILIKE :query
        OR pigeons.description ILIKE :query
        OR pigeons.summary ILIKE :query
        OR chats.sender_id IN (SELECT id FROM users WHERE nickname ILIKE :query)
        OR chats.recipient_id IN (SELECT id FROM users WHERE nickname ILIKE :query)
        "
      @pigeons = @pigeons.joins(chat: :sender).joins(chat: :recipient).where(sql_subquery, query: "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: "pigeons/list", locals: { pigeons: @pigeons }, formats: [:html] }
    end

    @pigeons = Pigeon.where(recipient: current_user).sort_by { |pigeon| [-pigeon.date.to_time.to_i, pigeon.title.downcase] }
    # @pigeons = Pigeon.where(recipient: current_user).sort_by { |pigeon| pigeon.title.downcase }
  end

  def toggle_read #toggle read on show page
    @pigeon = Pigeon.find(params[:id])
    @pigeon.read = !@pigeon.read
    @pigeon.save
    redirect_to root_path
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
    @pigeon.reply_later = !@pigeon.reply_later
    @pigeon.save
    redirect_to pigeon_path(@pigeon)
  end

  def show
    @pigeon = Pigeon.find(params[:id])
    @chat = @pigeon.chat
    @message = Message.new
  end

  def new
    @user = User.new
    @pigeon = Pigeon.new
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
  end

  # def edit
    # @pigeon = Pigeon.find(params[:id])
  # end

  # def update
    # @pigeon = Pigeon.find(params[:id])
    # if @pigeon.update(pigeon_params)
      # redirect_to pigeons_path(current_user)
    # else
      # render :edit, status: :unprocessable_entity
    # end
  # end

  def create
    # @pigeons = Pigeon.all
    @pigeon = Pigeon.new(pigeon_params)

    recipient_id = params[:pigeon][:recipient]
    @pigeon.recipient = User.find_by_id(recipient_id)
    # custom_tags = []
    @chat = Chat.find_by(sender: current_user, recipient: @pigeon.recipient)
    if @chat.nil?
      @chat = Chat.find_by(sender: @pigeon.recipient, recipient: current_user)
    end
    if @chat.nil?
      @chat = Chat.create(sender: current_user, recipient: @pigeon.recipient)
    end
    @pigeon.chat = @chat
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
        @pigeon.tag_names << custom_tags.strip.downcase unless custom_tags.strip.empty?
      end
    end

    @pigeon.user = current_user
    @pigeon.date = Date.today
    @pigeon.save
    @message = Message.new(sender: current_user, chat: @chat)
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
