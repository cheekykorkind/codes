class Light
  def on
    puts "전등이 켜졌습니다."
  end

  def off
    puts "전등이 꺼졌습니다."
  end
end

class LightOnCommand
  def initialize(light)
    @light = light
  end

  def execute
    @light.on
  end

  def undoe
    @light.off
  end
end

class LightOffCommand
  def initialize(light)
    @light = light
  end

  def execute
    @light.off
  end
end

class RemoteControl
  def initialize
    @history = []
  end

  def submit(command)
    command.execute
    @history << command
  end

  def undo_last
    return puts "취소할 작업이 없습니다." if @history.empty?

    last_command = @history.pop
    puts "작업 취소: "
    last_command.undo_last
  end
end

light = Light.new
remote = RemoteControl.new

on = LightOnCommand.new(light)
off = LightOffCommand.new(light)

remote.submit(on)
remote.submit(off)

remote.undo_last
remote.undo_last

class Asset
  def accept(visitor)
    raise NotImplementedError
  end
end

class Computer < Asset
  attr_reader :price
  def initialize(price); @price = price; end
  
  def accept(visitor)
    visitor.visit_computer(self)
  end
end

class Monitor < Asset
  attr_reader :resolution
  def initialize(resolution); @resolution = resolution; end

  def accept(visitor)
    visitor.visit_monitor(self)
  end
end

class AssetVisitor
  def visit_computer(computer); end
  def visit_monitor(monitor); end
end

class PricingVisitor < AssetVisitor
  attr_reader :total_price

  def initialize
    @total_price = 0
  end
  
  def visit_computer(computer)
    @total_price += computer.price
  end

  def visit_monitor(monitor)
    @total_price += (monitor.resolution == "4K" ? 500000 : 200000)
  end
end

inventory = [
  Computer.new(1500000),
  Monitor.new("4K")
  Monitor.new("FHD")
]

pricing_visitor = PricingVisitor.new

inventory.each do |asset|
  asset.accept(pricing_visitor)
end

puts "전체 자산 평가액: #{pricing_visitor.total_price}원"