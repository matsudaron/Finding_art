class BoardsController < ApplicationController
  before_action :require_login
  
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end
  
  def new
    @board = Board.new
  end
  
  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, success: t('.success', item: Board.model_name.human)
    else
      flash.now[:danger] = t('.fail', item: Board.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @board = Board.find(params[:id])
  end
  
  private
  
  def board_params
    params.require(:board).permit(:title, :body)
  end
end