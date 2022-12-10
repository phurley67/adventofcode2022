require 'rmagick'
include Magick
SIZE = 350

@count = 0
def debug(snake,trail)
  img = Image.new(SIZE, SIZE) { |img| img.background_color = 'black' }

  trail.keys.each do |x,y|
    img.pixel_color(x,y,'grey25')
  end

  snake.reverse.each_with_index do |point, index|
    x,y = *point
    img.pixel_color(x,y, "hsl(200,100%, #{index * 10}%)")
  end

  fname = 'frames/frame%05d.png' % [@count += 1]
  img.write(fname)
end

def follow(head, tail)
  dx = head[0] - tail[0]
  dy = head[1] - tail[1]

  if dx.abs > 1 || dy.abs > 1
    tail[0] += dx <=> 0
    tail[1] += dy <=> 0
  end
end

#cleanup old frames
Dir.glob('frames/frame*.png').each { |fn| puts fn ;File.unlink(fn) }

snake = Array.new(10) { [3,16] }
trail = {}

ARGF.each_line.map do |move|
  direction, distance = *move.split
  distance.to_i.times do
    # puts "Move #{direction}"
    case direction
    when 'U'
      snake.first[1] += 1
    when 'D'
      snake.first[1] -= 1
    when 'L'
      snake.first[0] -= 1
    when 'R'
      snake.first[0] += 1
    end
    snake.each_cons(2) do |head, tail|
      follow(head, tail)
    end
    debug(snake, trail)
    trail[snake.last.clone] = 1
  end
end

puts 'Writing video'
Dir.chdir('frames') do
  system("ffmpeg -r 60 -f image2 -i frame%05d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p ../snake.mp4")
end

puts trail.size
