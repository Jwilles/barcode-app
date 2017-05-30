class UpcApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    item = Item.find_by upc: params[:upc] 
    if item 
      if params[:method] == 'add'
        item.increment!(:quantity, by=1)
        head :ok
      elsif params[:method] == 'remove' && item.quantity > 0
        item.decrement!(:quantity, by=1)
        head :ok
      else
        head :internal_server_error
      end 
    else
      product = lookup_upc(params[:upc]) 
      if product 
        new_item = Item.new({name: product["description"], upc: product["upc"]})
        if new_item.save
          head :ok
        else
          head :internal_server_error
        end
      else
        head :bad_request
      end
    end
  end
end
