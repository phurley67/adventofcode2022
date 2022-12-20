require 'set'

def debug(blocks, grid)
  buffer = ""
  (0..12).each do |y|
    (494..504).each do |x|
      buffer << case
                when blocks.include?([x,y])
                  "#"
                when grid.include?([x,y])
                  "o"
                else
                  "."
                end
    end
    buffer << "\n"
  end
  puts buffer
end

input = ARGF.read.split(/\n/).map { |l| l.scan(/\d+/).map(&:to_i).each_slice(2).to_a }.to_a

grid = Set.new
input.each do |line|
  line.each_cons(2) do |(x1, y1), (x2, y2)|
    dx = x2 <=> x1
    dy = y2 <=> y1

    grid.add([x1, y1])
    while x1 != x2 || y1 != y2
      x1 += dx
      y1 += dy
      grid.add([x1, y1])
    end
  end
end
height = grid.map { |x,y| y }.max

(-10000..10000).each do |x|
  grid.add([x, height + 2])
end
blocks = grid.clone

n = 0
until grid.include?([500,0])
  x, y = 500, 0
  loop do
    if !grid.include?([x, y + 1])
      y += 1
    elsif !grid.include?([x - 1, y + 1])
      x -= 1
      y += 1
    elsif !grid.include?([x + 1, y + 1])
      x += 1
      y += 1
    else
      grid.add([x,y])
      if y - 1 == height
        height = nil
        puts "Part 1: #{n}"
        debug(blocks, grid)
      end
      n += 1
      break
    end
  end
end

puts "\nPart 2: #{n}"
debug(blocks, grid)
