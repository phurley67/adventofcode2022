COUNT = 6
def debug(snake)
  output = ''
  COUNT.downto(0) do |y|
    COUNT.times do |x|
      output << (snake.find_index([x, y]) || '.').to_s
    end
    output << "\n"
  end
  puts output
  puts
end

def follow(head, tail)
  dx = head[0] - tail[0]
  dy = head[1] - tail[1]

  return unless dx.abs > 1 || dy.abs > 1

  tail[0] += dx <=> 0
  tail[1] += dy <=> 0
end

snake = Array.new(2) { [0, 0] }
# debug(snake)
trail = {}
ARGF.each_line.each do |move|
  direction, distance = *move.split
  distance.to_i.times do
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
    follow(snake.first, snake.last)
    trail[snake.last.clone] = 1
    # debug(snake)
  end
end

puts trail.size
