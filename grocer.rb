def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  index = 0 
  
  while index < collection.length do 
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1 
  end
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  updated_cart = []
  item_index = 0 
  duplicate_index = 0 
  
  while item_index < cart.length do 
    item = cart[item_index][:item]
    
    if find_item_by_name_in_collection(item,updated_cart)
      index = 0 
      while index < updated_cart.length do 
        if updated_cart[index][:item] == item
          updated_cart[index][:count] += 1 
        else
          
        end
        index += 1 
      end
    else
      updated_cart[duplicate_index] = cart[item_index]
      updated_cart[duplicate_index][:count] = 1 
      duplicate_index += 1 
    end
    item_index += 1 
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  adjusted_cart = []
  cart_index = 0 
  coupon_cart = []
  
  while cart_index < cart.length do 
    valid_coupon = find_item_by_name_in_collection(cart[cart_index][:item], coupons)
    adjusted_cart[cart_index] = cart[cart_index]
    
    if valid_coupon
      
      if cart[cart_index][:count] >= valid_coupon[:num]
        adjusted_cart[cart_index][:count] = adjusted_cart[cart_index][:count] - valid_coupon[:num]
        
        coupon_name = valid_coupon[:item] + " W/COUPON"
        coupon_price = valid_coupon[:cost] / valid_coupon[:num]
        coupon_count = valid_coupon[:num]
        
        coupon_cart << { 
          :item=> coupon_name, 
          :price=> coupon_price,
          :count=> coupon_count,
          :clearance=> adjusted_cart[cart_index][:clearance]
        }
      else
        
      end
    else
      
    end
  
    cart_index += 1 
  end
  # janky check if adjusted_cart was used or not
  if adjusted_cart == []
    return adjusted_cart = cart
  else
    return adjusted_cart = adjusted_cart + coupon_cart
  end
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  clearance_cart = []
  index = 0 
  
  while index < cart.length do 
    clearance_cart[index] = cart[index]
    if cart[index][:clearance]
      clearance_cart[index][:price] = (cart[index][:price] * 0.8).round(2)
    else
      
    end
    index += 1 
  end
  
  clearance_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  final_cart = []
  
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  
  total = 0.00
  index = 0 
  while index < final_cart.length do 
    item_subtotal = (final_cart[index][:count] * final_cart[index][:price]).round(2)
    total += item_subtotal
    index += 1 
  end
  
  if total > 100.00
    return total = (total * 0.90).round(2)
  else
    return total
  end
  
end
