class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]

  def top
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).page(params[:page]).order('created_at desc')
  end
end
