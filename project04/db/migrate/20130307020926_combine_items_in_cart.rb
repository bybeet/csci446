class CombineItemsInCart < ActiveRecord::Migration
  def up
  	#replace multiple items for a single product in a cart with a single item
  	Cart.all.each do |cart|
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		sums.each do |product_id, quantity|
  			if quantity > 1
  				cart.line_items.where(product_id: product_id).delete_all

  				item = cart.line_items.build(product_id: product_id)
  				items.quantity = quantity
  				item.save!
  			end
  		end
  	end
  	
  end

  def down
  end
end
