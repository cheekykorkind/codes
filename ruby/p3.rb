class FileSystemItem
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def size
    raise NotImplementedError
  end
end

class FileItem < FileSystemItem
  def initailize(name, size)
    super(name)
    @size = size
  end

  def size
    @size
  end
end

class DirectoryItem < FileSystemItem
  def initialize(name)
    super(name)
    @children = []
  end

  def add(item)
    @children << item
  end

  def remove(item)
    @children.delete(item)
  end

  def size
    @children.map(&:size).sum
  end
end

file1 = FileItem.new("rails_manual.pdf", 500)
file2 = FileItem.new("ruby_logo.png", 200)
file3 = FileItem.new("config.yml", 100)

root_dir = DirectoryItem.new("Project")
docs_dir = DirectoryItem.new("Documents")
img_dir = DirectoryItem.new("Images")

docs_dir.add(file1)
docs_dir.add(file3)
img_dir.add(file2)

root_dir.add(docs_dir)
root_dir.add(img_dir)

puts "폴더명: #{root_dir.name}"
puts "전체 크기: #{root_dir.size}KB"

class VideoFile
  def initialize(filename); end
end

class CodecCompression
  def self.compress(file, type); puts "영상을 #{type} 코덱으로 압축합니다."; end
end

class AudioExtractor
  def self.extract(file); puts "오디오 트랙을 분리합니다."; end
end

class CloudUploader
  def self.upload(data); puts "클라우드 스토리지에 저장을 완료했습니다."; end
end

class VideoConverter
  def convert_and_upload(filename, format)
    puts "--- 비디오 변환 프로세스 시작 ---"
    file = VideoFile.new(filename)

    CodecCompression.compress(file, format)
    AudioExtractor.extract(file)
    CloudUploader.upload(file)

    puts "--- 모든 작업이 완료되었습니다! ---"
  end
end

converter = VideoConverter.new
converter.convert_and_upload("my_vlog.mp4", "h264")