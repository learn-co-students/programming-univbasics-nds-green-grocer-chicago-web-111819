require 'pp'

def find_item_by_name_in_collection(name, collection)
  #pp name
  #pp collection
  
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  row_index = 0
  
  while row_index < collection.length do
    if name === collection[row_index][:item]
   return collection[row_index]
    else
      nil
    end
    
    row_index += 1
  end
end

def consolidate_cart(cart)

  #pp cart

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  unique_cart_items = []
  row_index = 0
  
  while row_index < cart.length do
    name = cart[row_index][:item]
    item = cart[row_index]
    already_in_cart = find_item_by_name_in_collection(name, unique_cart_items)
    
    if already_in_cart
      already_in_cart[:count] += 1
      
    else
      item[:count] = 1
      unique_cart_items.push(item)
    end
    row_index += 1
  end

  unique_cart_items

end

=begin
def make_coupons(xcart, xcoupons)
  {
    :item => "#{xcoupons[:item]} W/COUPON",
    :price => (xcoupons[:cost]/xcoupons[:num]).round(3),
    :clearance => xcart[:clearance],
    :count => xcoupons[:num]
  }
  
end
=end

def apply_coupons(cart, coupons)

  #pp cart
  #pp coupons

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  row_index = 0
  while row_index < coupons.length do
    coupon_item = coupons[row_index][:item]
    coupon_num = coupons[row_index][:num]
    coupon_cost = coupons[row_index][:cost]
    coup_clear = coupons[row_index][:clearance]
    find_coupon_item = find_item_by_name_in_collection(coupon_item, cart)
    cart_item = cart[row_index][:item]
    cart_count = cart[row_index][:count]
    cart_clear = cart[row_index][:clearance]
    

    if find_coupon_item && find_coupon_item[:count] >= coupon_num
      find_coupon_item[:count] -= coupon_num

      cart.push(
        {
          :item => "#{coupon_item} W/COUPON",
          :price => (coupon_cost/coupon_num).round(3),
          :clearance => find_coupon_item[:clearance],
          :count => coupon_num
        }  
      )
    end

    row_index += 1
  end
  
  cart
end

def apply_clearance(cart)
  #pp cart
 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  row_index = 0
  
  while row_index < cart.length do
    item = cart[row_index]
    
    if item[:clearance]
      item[:price] = (0.8 * item[:price]).round(2) #=>20% discount
    end
    row_index += 1
  end

  cart
end

def checkout(cart, coupons)
  #pp cart
  #pp coupons
  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  grand_total = 0
  row_index = 0
  
  final_cart = consolidate_cart(cart)
  final_cart
  apply_coupons(final_cart, coupons)
  apply_clearance(final_cart)
  
  while row_index < final_cart.length do
    grand_total += (final_cart[row_index][:count] * final_cart[row_index][:price])
    row_index += 1
  end
    
  if grand_total > 100
    grand_total = (grand_total * 0.9) #=>10% discount
  end
    
  grand_total

end
