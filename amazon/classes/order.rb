class Order
  attr_reader :user, :product
  @@all = []

  def initialize(product, user)
    @user = user
    @product = product
    @@all.push(self)
  end

  def Order.all
    @@all
  end

  def Order.total_revenue
    total = 0
    @@all.each do |order|
      total += order.product.price
    end
    return total
  end
end
