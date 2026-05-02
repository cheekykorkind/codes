class Button
  def render
    raise NotImplementedError
  end
end

class Checkbox
  def render
    raise NotImplementedError
  end
end

class MacButton < Button
  def render
    puts "Mac 스타일의 둥근 버튼을 그립니다."
  end
end

class WinButton < Button
  def render
    puts "Windows 스타일의 각진 버튼을 그립니다."
  end
end

class MacCheckbox < Checkbox
  def render
    puts "Mac 체크박스: [X]"
  end
end

class WinCheckbox < Checkbox
  def render
    puts "Windows 체크박스: [x]"
  end
end

class GUIFactory
  def create_button
    raise NotImplementedError
  end
  def create_checkbox
    raise NotImplementedError
  end
end

class MacFactory < GUIFactory
  def create_button
    MacButton.new
  end
  def create_checkbox
    MacCheckbox.new
  end
end

class WinFactory < GUIFactory
  def create_button
    WinButton.new
  end
  def create_checkbox
    WinCheckbox.new
  end
end

def build_ui(factory)
  button = factory.create_button
  checkbox = factory.create_checkbox

  button.render
  checkbox.render
end

myos = "Mac"
factory = (myos == "Mac" ? MacFactory.new : WinFactory.new)

puts "현재 OS: #{myos}"
build_ui(factory)

class EmailSender
  def send(message)
    puts "이메일 발송: #{message}"
  end
end

class SlackSender
  def send(message)
    puts "슬랙 메시지 전송: #{message}"
  end
end

class NotificationService
  def initialize(sender)
    @sender = sender
  end

  def notify(message)
    @sender.send(message)
  end
end

email_notifier = NotificationService.new(EmailSender.new)
email_notifier.notify("서버 점검 공지입니다.")

slack_notifier = NotificationService.new(SlackSender.new)
slack_notifier.notify("긴급 장애 발생!")