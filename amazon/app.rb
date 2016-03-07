require "pry"

require_relative "classes/user"
require_relative "classes/product"
require_relative "classes/order"

alice = User.new("Alice")
bob = User.new("Bob")
sneakers = Product.new("Air Jordans", 99.00)
alice.order(sneakers)
bob.order(sneakers)

binding.pry

puts "Done!"
