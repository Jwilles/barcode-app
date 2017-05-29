class ItemsController < ApplicationController

  before_action :logged_in_user # only: [:index, :create, :edit, :update, :destroy]

  def index 
    if params[:search]
      @items = Item.where(name: params[:search])
    else
      @items = Item.all
    end
  end
 
  def new 
  end

  def create
    item = Item.find_by upc: params[:upc] 
    if item 
      if params[:method] == 'add'
        new_quant = item.quantity += 1
        item.update_attributes(quantity: new_quant)
        flash[:success] = "Item Added" 
        redirect_to items_path
      elsif params[:method] == 'remove' && item.quantity > 0
        new_quant = item.quantity -= 1
        item.update_attributes(quantity: new_quant)
        flash[:success] = "Item Removed"
        redirect_to items_path
      else
        flash[:danger] = "No items in inventory to remove"
        redirect_to items_path
      end 
    else
      product = lookup_upc(params[:upc]) 
      new_item = Item.new({name: product["description"], upc: product["upc"]})
      if new_item.save
        flash[:success] = "Item added successfully"
        redirect_to items_path
      else
        flash[:danger] = "Unable to add item"
        redirect_to items_path
      end
    end
  end

  private 

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end
  
end
