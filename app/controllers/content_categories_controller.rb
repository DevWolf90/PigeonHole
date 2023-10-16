class ContentCategoriesController < ApplicationController

  def index
    @contentcategories = ContentCategory.where(owner_id: current_user)
  end

end
