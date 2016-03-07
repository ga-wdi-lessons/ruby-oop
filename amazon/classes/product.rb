class Product
  attr_accessor :orders, :price, :title
  @@all = []

  def initialize(title, price)
    @title = title
    @price = price
    @orders = []
    @@all.push(self)
  end

  def total_sales
    return (self.price * @orders.count)
  end

  def Product.named name
    return @@all.select{|p| p.title == name}.first
  end

  def Product.all
    @@all
  end
end
