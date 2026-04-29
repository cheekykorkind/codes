class Post
  attr_reader :title, :observers

  def initialize(title)
    @title = title
    @observers = []
  end

  def add_observer(observer)
    @observer << observer
  end

  def publish
    puts "--- [#{title}] 포스팅이 발행되었습니다! ---"
    notify_observers
  end

  private

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class EmailSubscriber
  def update(post)
    puts "[Email] '#{post.title}' 알림을 보냈습니다."
  end
end

class PushSubscriber
  def update(post)
    puts "[Push] 스마트폰 앱으로 '#{post.title}' 팝업을 띄웁니다."
  end
end

blog_post = Post.new("루비 객체 지향의 비밀")

blog_post.add_observer(EmailSubscriber.new)
blog_post.add_observer(PushSubscriber.new)

blog_post.publish

class Coffee
  def cost
    3000
  end

  def description
    "기본 커피"
  end
end

class CoffeeDecorator
  def initialize(coffee)
    @coffee = coffee
  end

  def cost
    @coffee.cost
  end

  def description
    @coffee.description
  end
end

class MilkDecorator < CoffeeDecorator
  def cost
    @coffee.cost + 500
  end
  
  def description
    "#{@coffee.description}, 시럽 추가"
  end
end

order = Coffee.new
puts "#{order.description} | 가격: #{order.cost}원"

latte = MilkDecorator.new(latte)
puts "#{sweet_latte.description} | 가격: #{sweet_latte.cost}원"