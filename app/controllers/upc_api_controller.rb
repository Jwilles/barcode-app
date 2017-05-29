class UpcApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    item = Item.find_by upc: params[:upc] 
    if item 
      if params[:method] == 'add'
        new_quant = item.quantity += 1
        item.update_attributes(quantity: new_quant)
        head :ok
      elsif params[:method] == 'remove' && item.quantity > 0
        new_quant = item.quantity -= 1
        item.update_attributes(quantity: new_quant)
        head :ok
      else
        head :internal_server_error
      end 
    else
      product = lookup_upc(params[:upc]) 
      new_item = Item.new({name: product["description"], upc: product["upc"]})
      if new_item.save
        head :ok
      else
        head :internal_server_error
      end
    end
  end
end
