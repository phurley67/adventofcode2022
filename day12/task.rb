require 'set'

def bfs(maze, start, stop)
  queue = [[start, 0]]
  height = maze.size
  width = maze.first.size
  visited = Set.new
  best = height * width

  until queue.empty?
    cur, score = queue.shift
    if cur == stop && score < best
      best = score
      next
    end
    next if visited.include?(cur)

    visited.add(cur)
    max_height = maze[cur[1]][cur[0]].ord + 1

    up = [cur[0], cur[1] + 1]
    down = [cur[0], cur[1] - 1]
    left = [cur[0] - 1, cur[1]]
    right = [cur[0] + 1, cur[1]]

    [up, down, left, right].each do |dir|
      next if dir[0].negative? || dir[1].negative?
      next if dir[0] >= width || dir[1] >= height

      new_height = maze[dir[1]][dir[0]].ord
      next if new_height > max_height

      queue << [dir, score + 1]
    end
  end

  best
end

maze = ARGF.each_line.map { |line| line.chomp.chars }

start = [0, 0]
stop = [0, 0]
a_positions = []

maze.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    case cell
    when 'S'
      start = [x, y]
      maze[y][x] = 'a'
    when 'E'
      stop = [x, y]
      maze[y][x] = 'z'
    when 'a'
      a_positions.push([x, y])
    end
  end
end

puts "Part one: #{bfs(maze, start, stop)}"
puts "Part two: #{a_positions.map { |a| bfs(maze, a, stop) }.min}"