
class PigeonsController < ApplicationController
  before_action :set_pigeons, only: %i[index show]

  def index
    @content_categories = ContentCategory.where("owner_id = ? OR creator_id = ?", current_user.id, current_user.id)
    @mediatypes = ["article", "book", "movie", "playlist", "podcast", "song", "video", "other"]
    @pigeons = Pigeon.where(recipient: current_user)

    if params[:q].present? && params[:q][:tags_name_cont_any].present?
      selected_content_categories = params[:q][:tags_name_cont_any]
      pigeons_with_selected_content_categories = @pigeons.joins(:labels)
      # pigeons_with_selected_content_categories = []
      selected_content_categories.each do |cc|
        content_category_id = ContentCategory.find_by(name: cc).id
        pigeons_with_selected_content_categories = pigeons_with_selected_content_categories.where(labels: { content_category_id: content_category_id })
        # pigeons_with_selected_content_categories += @pigeons.joins(:labels).where(labels: {content_category_id: content_category_id})
      end
      raise
    end

    if params[:q].present? && params[:q][:media_type].present?
      selected_media_types = params[:q][:media_type]
      pigeons_with_selected_media_types = []
      pigeons_with_selected_media_types = @pigeons.where(media_type: selected_media_types).to_a

    end

    if pigeons_with_selected_content_categories && pigeons_with_selected_media_types
      @pigeons = pigeons_with_selected_content_categories + pigeons_with_selected_media_types
    elsif pigeons_with_selected_content_categories
      @pigeons = pigeons_with_selected_content_categories
    elsif pigeons_with_selected_media_types
      @pigeons = pigeons_with_selected_media_types
    end

    if params[:query].present?
      query = "%#{params[:query]}%"
      pigeons_query = []
      pigeons_query = Pigeon.joins(chat: [:sender, :recipient]).where(
        "pigeons.title ILIKE :query OR pigeons.description ILIKE :query OR pigeons.summary ILIKE :query OR users.nickname ILIKE :query",
        query: query
      )
      @pigeons += pigeons_query
    end

    # @pigeons = @pigeons.first
    @pigeons = @pigeons.sort_by { |pigeon| [-pigeon.date.to_time.to_i, pigeon.title.downcase] }
    respond_to do |format|
      format.html
      format.text {
        render partial: "pigeons/list", locals: { pigeons: @pigeons }, formats: [:html] }
    end

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
    @content_categories = ContentCategory.all
    # @content_categories = ContentCategory.where("owner_id = ? OR creator_id = ?", current_user.id, current_user.id)
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
    @content_categories = ContentCategory.where("owner_id = ? OR creator_id = ?", current_user.id, current_user.id)
    new_content_categories = params[:pigeon][:new_content_categories]

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
    selected_content_categories = params[:pigeon][:new_content_categories]
    unless selected_content_categories.nil?
      selected_content_categories.each do |category_id|
        category = ContentCategory.find_by(id: category_id)
        @pigeon.content_categories << category if category.present?
        end
    end

    custom_categories = params[:pigeon][:content_categories]
    unless custom_categories.nil?
      custom_categories.each do |cc|
        if cc.include?(",")
          cc.split(",").each do |category|
            @pigeon.content_categories << category.strip.downcase unless category.strip.empty?
          end
        else
          @pigeon.content_categories << cc.strip.downcase unless cc.strip.empty?
        end
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
    params.require(:pigeon).permit(:link_to_content, :title, :description, :media_type, :new_content_categories, [:tags_name_cont_any])

  end

  def set_pigeons
    @pigeons = Pigeon.where(recipient: current_user)
  end
end
