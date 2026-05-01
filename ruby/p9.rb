class Paymentgateway
  def process_payment(amount)
    raise NotImplementedError, "서브클래스에서 process_payment를 구현해야합니다."
  end
end

class KakaoPay < PaymentGateway
  def process_payment(amount)
    puts "카카오페이로 #{amount}원을 결제합니다. (카카오 API 연결...))"
    true
  end
end

class TossPay < PaymentGateway
  def process_payment(amount)
    puts "토스페이로 #{amount}원을 결제합니다. (토스 SDK 호출...)"
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
kakaopay_service.execute(500000)

tosspay_service = PaymentService.new(TossPay.new)
tosspay_service.execute(300000)

class User
  attr_reader :name, :email

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

    UserLogger.log_registration(user)
    WelcomeMailer.send_email(user)

    user
  end
end

service = UserRegistrationService.new
service.register("레일즈마스터", "master@rails.com")