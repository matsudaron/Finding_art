class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]

  def top
    @board = Board.all
  end
end
