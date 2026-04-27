class TreeType
  attr_reader :name, :color, :texture

  def initailize(name, color, texture)
    @name = name
    @color = color
    @texture = texture
  end

  def draw(x, y)
    puts "[#{@name}/#{@color}] 나무를 (#{x}, #{y}) 좌표에 렌더링합니다."
  end
end

class TreeFactory
  @tree_types = {}

  def self.get_tree_type(name, color, texture)
    key = "#{name}_#{color}"
    @tree_types[key] ||= TreeType.new(name, color, texture)
  end
end

class Tree
  def initailize(x, y, type)
    @x = x
    @y = y
    @type = type
  end

  def draw
    @type.draw(@x, @y)
  end
end

class Forest
  def initialize
    @trees = []
  end

  def plant_tree(x, y, name, color, texture)
    type = TreeFactory.get_tree_type(name, color, texture)
    tree = Tree.new(x, y, type)
    @trees << tree
  end

  def draw
    @trees.each(&:draw)
  end
end

forest = Forest.new

10000.times { |i| forest.plant_tree(rand(100), rans(100), "소나무", "Green", "TEXT_DATA_V1") }

forest.draw

class DiscountStrategy
  def apply_discount(amount)
    raise NotImplementedError
  end
end

class NoDiscount < DiscountStrategy
  def apply_discount(amount)
    amount
  end
end

class ChristmasDiscount < DiscountStrategy
  def apply_discount(amount)
    amount * 0.9
  end
end

class FlatAmountDiscount < DiscountStrategy
  def apply_discount(amount)
    [amount - 5000, 0].max
  end
end

class Order
  attr_accessor :amount, :discount_strategy

  def initialize(amount, discount_strategy = NoDiscount.new)
    @amount = amount
    @discount_strategy = discount_strategy
  end

  def final_price
    @discount_strategy.apply_discount(@amount)
  end
end

order = Order.new(100000)
puts "기본 가격: #{order.final_price}원"

order.discount_strategy = ChristmasDiscount.new
puts "크리마스 할인 적용: #{order.final_price}원"

order.discount_strategy = FlatAmountDiscount.new
puts "고정액 할일 적용: #{order.final_price}원"