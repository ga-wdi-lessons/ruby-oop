class User
  attr_reader :orders

  def initialize(name)
    @name = name
    @password = encode_password(name)
    @orders = []
  end

  def order(product)
    order = Order.new(product, self)
    @orders.push(order)
    product.orders.push(order)
  end

  def authorize(password)
    puts "*" * 10
    if compare_password(password)
      puts "You're authorized!"
    else
      puts "Incorrect password"
    end
    puts "*" * 10
  end

  private
  def encode_password input
    input.reverse
  end

  def compare_password input
    if input == @password
      return true
    else
      return false
    end
  end
end
