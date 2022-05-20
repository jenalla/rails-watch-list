class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]
  before_action :set_list, only: %i[new create edit update]
  def new
    @bookmark = Bookmark.new
    @bookmark.list = @list
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list.id)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @bookmark.update(bookmark_params)
    # No need for app/views/bookmarks/update.html.erb
    redirect_to list_path(@list.id)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
