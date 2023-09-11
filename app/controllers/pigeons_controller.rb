
class PigeonsController < ApplicationController
  before_action :set_pigeons, only: %i[index show]

  def index
    @alltags = Gutentag::Tag.names_for_scope(Pigeon)
    @mediatypes = ["video", "podcast", "article", "playlist", "movie", "book", "song"]


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

  def unmark_read
    @pigeon = Pigeon.find(params[:id])
    @pigeon.read = !@pigeon.read
    @pigeon.save
  end

  # def mark_read
  #   @pigeon = Pigeon.find(params[:id])
  #   @pigeon.read = !@pigeon.read
  #   @pigeon.save
  # end

  def show
    @pigeon = @pigeons.find(params[:id])
  end

  def new
    @user = User.new()
    @pigeon = Pigeon.new
  end

  def create
    @pigeon = Pigeon.new(pigeon_params)
    @chat = Chat.where(sender: current_user).where(recipient: @pigeon.recipient)
    if @chat.nil?
      @chat = @chat = Chat.where(sender: @pigeon.recipient).where(recipient: current_user)

    end
    if @chat.nil?
      @chat = Chat.create(sender: current_user, recipient: @pigeon.recipient)
    end
    @pigeon.chat = @chat
    @pigeon.save
    @message = Message.new(user: current_user, chat: @chat)
    @message.content = @pigeon.description
    @message.save
    redirect_to pigeons_path(@pigeons)
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

  def destroy
    @pigeon = Pigeon.find(params[:id])
    @pigeon.destroy
    redirect_to pigeons_path, notice: "Pigeon was successfully deleted!", status: :see_other
  end

  private

  def pigeon_params
    params.require(:pigeon).permit(:link_to_content, :title, :media_type, :description)
  end

  def set_pigeons
    @pigeons = Pigeon.where(recipient: current_user)
  end


end
