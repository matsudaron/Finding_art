class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @board = @bookmark.board
    @bookmark.destroy
    respond_to do |format|
      format.turbo_stream # デフォルトでは app/views/bookmarks/destroy.turbo_stream.erb がレンダリングされる
    end
  end
end
