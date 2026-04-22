class PaymentGateway
  def process_payment(amount)
    raise NotImplementedError, "서브클래스에서 process_payment를 구현해야 합니다."
  end
end

class KakaoPay < PaymentGateway
  def process_payment(amount)
    puts "카카오페이로 #{amount}원을 결제합니다."
    true
  end
end

class TossPay < PaymentGateway
  def process_payment(amount)
    puts "토스페이로 #{amount}원을 결제합니다."
    true
  end
end

class PaymentService
  def initialize(gateway)
    @gateway = gateway
  end

  def execute(amount)
    @gateway.process_payment(amount)
  end
end

kakaopay_service = PaymentService.new(KakaoPay.new)
kakaopay_service.execute(50000)

tosspay_service = PaymentService.new(TossPay.new)
tosspay_service.execute(30000)

###

class User
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
end

class UserLogger
  def self.log_registration(user)
    puts "[LOG] #{Time.now}: #{user.name} 가입 완료"
  end
end

class WelcomeMailer
  def self.send_email(user)
    puts "[EMAIL] #{user.email}로 환영 메시지를 보냈습니다."
  end
end

class UserRegistrationService
  def register(name, email)
    user = User.new(name, email)

    User.Logger.log_registration(user)
    WelcomMailer.send_email(user)

    user
  end
end

service = userRegistrationService.new
service.register("레일즈마스터", "master@rails.com")

###

class State
  attr_reader :article

  def initialize(article)
    @article = article
  end

  def publish!
    raise NotImplementedError
  end
end

class DraftState < State
  def publish!
    puts "초안을 제출하여 심사(Review) 상태로 변경합니다."
    @article.state = ReviewState.new(@article)
  end
end

class ReviewState < State
  def publish!
    puts "심사가 완료되어 최종 발행(Published) 상태로 변경합니다."
    @article.state = PublishedState.new(@article)
  end
end

class PublishedState < State
  def publish!
    puts "이미 발행된 글입니다. 더 이상 발행할 수 없습니다."
  end
end

class Article
  attr_accessor :state

  def initialize
    @state = DraftState.new(self)
  end

  def publish!
    @state.publish!
  end
end

my_post = Article.new
my_post.publish!
my_post.publish!
my_post.publish!