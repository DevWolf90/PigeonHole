class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @pigeons = Pigeon.where(recipient: current_user).sort_by {|pigeon| pigeon.created_at}
    @pigeons = @pigeons.reverse()
  end
end
