class BoardsController < ApplicationController
  before_action :require_login, only: %i[index new create edit update destroy bookmarks]
  before_action :set_board, only: %i[edit update destroy]
  
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).page(params[:page]).order('created_at desc')
    render 'static_pages/top'
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
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
    @bookmarks_count = @board.bookmarks_count
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('.success', item: Board.model_name.human)
    else
      flash.now[:danger] = t('.fail', item: Board.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    redirect_to root_path, success: t('.success', item: Board.model_name.human)
  end

  def bookmarks
    @bookmark_boards = current_user.bookmarked_boards.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end
  
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache, :address, :latitude, :longitude)
  end
end
