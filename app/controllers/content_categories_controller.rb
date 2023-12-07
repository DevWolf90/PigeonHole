class ContentCategoriesController < ApplicationController

  def index
    recipient_id = params[:recipient_id]
    @content_categories = ContentCategory.where("owner_id = ? OR creator_id = ?", recipient_id, recipient_id)
    render json: @content_categories
    @content_category = ContentCategory.new
  end

  def create
    @content_category = ContentCategory.new(content_category_params)
    @content_category.creator_id = current_user.id
    @content_category.save
  end

  private

  def content_category_params
    params.require(:content_category).permit(:name)
  end

end
