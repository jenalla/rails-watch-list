class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @bookmark = Bookmark.new
    @bookmark.list = @list
  end

  def edit; end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  def update
    @list.update(list_params)
    # No need for app/views/lists/update.html.erb
    redirect_to lists_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
