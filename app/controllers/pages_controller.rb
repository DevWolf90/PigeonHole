class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @pigeons = Pigeon.where(recipient: current_user)
  end
end
