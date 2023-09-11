class UsersController < ApplicationController

  def index
    if params[:query].present?
      sql_subquery = "nickname ILIKE :query OR email ILIKE :query"
      @users = User.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end
end
