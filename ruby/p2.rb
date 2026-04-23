class Burger
  attr_accessor :patty, :cheese, :lettuce, :tomato, :sauce

  def inspect
    "Burger [패티: #{@patty}, 치즈: #{@cheese}, 상추: #{@lettuce}, 토마토: #{@tomato}, 소스: #{@sauce}]"
  end
end

class BurgerBuilder
  def initialize
    @burger = Burger.new
    @burger.patty = "Beef"
    @burger.cheese = false
    @burger.cheese = false
    @burger.tomato = false
    @burger.sauce = "Mayo"
  end

  def add_lettuce
    @burger.lettuce = true
    self
  end

  def add_tomato
    @burger.tomato = true
    self
  end

  def set_patty(type)
    @burger.patty = type
  end

  def set_sauce(type)
    @burger.sauce = type
    self
  end

  def build
    @burger
  end
end

my_burger = BurgerBuilder.new
                        .add_cheese
                        .add_tomato
                        .set_sauce("BBQ")
                        .build

puts my_burger.inspect

vegan_burger = BurgerBuilder.new
                            .set_patty("Soy Bean")
                            .add_lettuce
                            .build
puts vegan_burger.inspect

class ReportGenerator
  def generate(data)
    header
    body(data)
    footer
  end

  def header
    puts "==== 리포트 시작 ===="
  end

  def body(data)
    raise NotImplementedError, "서브클래스에서 body를 구현해야 합니다."
  end

  def footer
    puts "===== 리포트 끝 ====="
  end
end

class HTMLReport < ReportGenerator
  def body(data)
    puts "<html><body>#{data}</body></html>"
  end
end

class CSVReport <ReportGenerator
  def body(data)
    puts "DATA,#{data}"
  end

  def footer
    puts "--- CSV End ---"
  end
end

puts "HTML 리포트 실행:"
html_report = HTMLReport.new
html_report.generate("사용자 명단")

puts "\nCSV 리포트 실행:"
csv_report = CSVReport.new
csv_report.generate("매출 데이터")

