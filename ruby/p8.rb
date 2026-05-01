class Book
  attr_reader :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end
end

class Library
  include Enumerable

  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def each(&block)
    puts "--- 도서 목록 순회를 시작합니다 (내부 구조: Array) ---"
    @books.each(&block)
  end
end

my_library = Library.new
my_library.add_book(Book.new("루비의 정석", "마츠모토"))
my_library.add_book(Book.new("레일즈 가이드", "DHH"))
my_library.add_book(Book.new("객체지향의 사실과 오해", "오해"))

my_library.each {|book| puts "제목: #{book.title}, 저자: #{book.author}"}

rails_books = my_library.select { |book| book.title.include?("레일즈") }
puts "검색 결과: #{rails_books.first.title}"

class EditorMemento
  attr_reader :content, :cursor_x, :cursor_y

  def initialize(content, x, y)
    @content = content
    @cursor_x = x
    @cursor_y = y
    @data = Time.new
  end
end

class Editor
  attr_accessor :content, :cursor_x, :cursor_y

  def initialize
    @content = ""
    @cursor_x = 0
    @cursor_y = 0
  end

  def type(text)
    @content += text
  end

  def move_cursor(x, y)
    @cursor_x, @cursor_y = x, y
  end

  def save
    puts "현재 상태를 저장합니다: '#{@content}'"
    EditorMemento.new(@content, @cursor_x, @cursor_y)
  end

  def restore(memento)
    @content = memento.content
    @cursor_x = memento.cursor_x
    @cursor_y = memento.cursor_y
    puts "상태를 복구했습니다: '#{@content}"
  end

  def status
    "내용: [#{@content}] | 커서: (#{@cursor_x}, #{@cursor_y})"
  end
end

class History
  def initialize(editor)
    @editor = editor
    @mementos = []
  end

  def backup
    @mementos << @editor.save
  end

  def undo
    return if @mementos.empty?
    memento = @mementos.pop
    @editor.restore(memento)
  end
end

editor = Editor.new
history = History.new(editor)

editor.type("Hello ")
history.backup

editor.type("World!")
editor.move_cursor(10, 5)
puts editor.status

editor.content = "Oops! Everythin deleted."
puts "실수 발생: #{editor.status}"

history.undo
puts "복구 후: #{editor.status}"