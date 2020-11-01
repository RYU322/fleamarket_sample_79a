class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :show]
  before_action :set_parents, only: [:new, :create]

  def index
    @items = Item.includes(:images).where(user_id: current_user).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item.images.new

  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, 
      :introduction, 
      :category, 
      :brand_id, 
      :item_condition, 
      :postage_payer, 
      :prefecture, 
      :preparation_period, 
      :price, 
      :user_id, 
      images_attributes: [:src, :_destroy, :id]
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil).limit(13)
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def search
    respond_to do |format|
      format.html
      format.json do
          @childrens = Category.find(params[:parent_id]).children
      end
    end
  end
end
