def follow(head, tail)
  dx = head[0] - tail[0]
  dy = head[1] - tail[1]

  return unless dx.abs > 1 || dy.abs > 1

  tail[0] += dx <=> 0
  tail[1] += dy <=> 0
end

snake = Array.new(10) { [0,0] }
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
    snake.each_cons(2) do |head, tail|
      follow(head, tail)
    end
    trail[snake.last.clone] = 1
  end
end

puts trail.values.size
