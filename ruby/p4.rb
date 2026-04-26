class Device
  def enable; raise NotImplementedError; end
  def disable; raise NotImplementedError; end
  def set_volume(percent); raise NotImplemetedError; end
end

class Tv < Device
  def enable; puts "TV 전원을 켭니다."; end
  def disable; puts "TV 전원을 끕니다."; end
  def set_volume(v); puts "TV 볼륨을 #{v}%로 조절합니다."; end
end

class Radio < Device
  def enable; puts "라디오를 켭니다."; end
  def disable; puts "라디오를 끕니다." end
  def set_volume(v); puts "라디오 불륨을 #{v}%로 조절합니다."; end
end

class RemoteControl
  def initialize(device)
    @device = device
  end

  def toggle_power
    @device.enable
  end

  def volume_up
    @device.set_volume(50)
  end
end

class AdvancedRemoteControl < RemoteControl
  def mute
    puts "음소거 기능을 실행합니다."
    @device.set_volume(0)
  end
end

tv = Tv.new
radio = Radio.new

basic_remote = RemotedControl.new(tv)
basic_remote.toggle_power

smart_remote = AdvancedRemoteControl.new(radio)
smart_remote.toggle_power
smart_remote.mute

class HomeMediator
  attr_accessor :ligth, :air_conditioner, :curtain

  def notify(sender, event)
    if event == "OUT_MODE_ON"
      puts "[중재자] 외출 모드 감지: 모든 기기를 제어합니다."
      @light.off
      @air_conditioner.off
      @cutain.close
    elsif event == "MOVIE_MODE_ON"
      puts "[중재자] 영화 모드 감지: 분위기를 조성합니다."
      @light.dim
      @curtain.close
    end
  end
end

class SmartDevice
  def initialize(mediator)
    @mediator = mediator
  end
end

class Light < SmartDevice
  def off; puts "전등: 불을 끕니다."; end
  def dim; puts "전등: 조도를 납춥니다."; end
end

class AirConditioner < SmartDevice
  def off; puts "에어컨: 전원을 끕니다."; end
end

class Curtain < SmartDevice
  def close; puts "커튼: 창문을 닫습니다."; end
end

mediator = HomeMediator.new

light = Light.new(mediator)
ac = AirContioner.new(mediator)
curtain = Curtain.new(mediator)

mediator.light = light
mediator.air_conditioner = ac
mediator.curtain = curtain

mediator.notify(nil, "OUT_MODE_ON")