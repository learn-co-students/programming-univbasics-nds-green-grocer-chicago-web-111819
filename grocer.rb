#require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  name 
  collection 
  #binding.pry 
   
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name 
      return collection[i]
    else 
      i += 1 
    end 
  end   
  
  
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  array = [] 
  i = 0 
  while i < cart.length do 
    new_item = find_item_by_name_in_collection(cart[i][:item], array)
    if new_item != nil 
      new_item[:count] += 1 
    else  
      new_item = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1 
      } 
      array << new_item
    end 
    i += 1 
  end
  return array   
  
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  while i < coupons.length do 
    item = find_item_by_name_in_collection(coupons[i][:item], cart)
    name_w_coupon = "#{coupons[i][:item]} W/COUPON"
    item_w_coupon = find_item_by_name_in_collection(name_w_coupon, cart)
    
    if item && item[:count] >= coupons[i][:num]
      if item_w_coupon 
        item_w_coupon[:count] += coupons[i][:num]
        item[:count] -= coupons[i][:num]
      else 
        item_w_coupon = {
          :item => name_w_coupon,
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => item[:clearance],
          :count => coupons[i][:num]
        }
        cart << item_w_coupon
        item[:count] -= coupons[i][:num]
      end 
    end 
    i += 1
  end 
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
    end 
    i += 1 
  end 
  return cart 
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
  
  new_cart = consolidate_cart(cart) 
  newer_cart = apply_coupons(new_cart,coupons)
  newest_cart = apply_clearance(newer_cart)
  
  i = 0 
  sum = 0 
  while i < newest_cart.length do 
    sum += (newest_cart[i][:price] * newest_cart[i][:count])
    i += 1 
  end 
  
  if sum > 100 
    new_sum = (sum - (sum * 0.10)).round(2)
    return new_sum
  else 
    return sum 
  end 
end
