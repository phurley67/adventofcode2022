require 'set'

ROCKS = [[[2, 0], [3, 0], [4, 0], [5, 0]],
         [[3, 0], [2, 1], [3, 1], [4, 1], [3, 2]],
         [[2, 0], [3, 0], [4, 0], [4, 1], [4, 2]],
         [[2, 0], [2, 1], [2, 2], [2, 3]],
         [[2, 0], [3, 0], [2, 1], [3, 1]]].freeze
GUSTS = ARGF.read.chomp.freeze

def debug(chamber, rock = [], dx = 0, dy = 0)
  buffer = ""
  (chamber_height(chamber) + 2 + (rock.size > 0 ? 3 : 0)).downto(1) do |row|
    buffer << "|"
    7.times do |col|
      ch = chamber.include?([col, row]) ? '#' : ' '
      ch = '@' if rock.any? { |x, y| [x + dx, y + dy] == [col, row] }
      buffer << ch
    end
    buffer << "|\n"
  end
  buffer << "+-------+\n"
  puts buffer
  puts
end

def chamber_height(chamber)
  chamber.map { |_, y| y }.max.to_i
end

def valid_move?(chamber, rock, dx, dy)
  # pp ["valid_move?", chamber, rock, dx, dy]
  rock.all? { |x, y| (0..6).cover?(x + dx) && !chamber.include?([x + dx, y + dy]) }
end

def place_rock(chamber, rock, dx, dy)
  rock.each { |x, y| chamber.add([x + dx, y + dy])}
end

def add_rock(chamber, rock, index)
  dy = chamber_height(chamber) + 4
  dx = 0
  # debug(chamber, rock, dx, dy)
  loop do
    gust = GUSTS[index % GUSTS.size] == '>' ? 1 : -1
    index += 1

    dx += gust if valid_move?(chamber, rock, dx + gust, dy)
    # puts "gust #{gust} #{[dx,dy].inspect}"
    # debug(chamber, rock, dx, dy)
    if valid_move?(chamber, rock, dx, dy - 1)
      dy -= 1
      # puts "drop"
      # debug(chamber, rock, dx, dy)
    else
      place_rock(chamber, rock, dx, dy)
      # puts "place"
      # debug(chamber)
      return index
    end
  end
end

index = 0
chamber = Set.new
7.times { |x| chamber.add([x, 0])}
2022.times do |rock_count|
  index = add_rock(chamber, ROCKS[rock_count % ROCKS.size], index)
end
puts "Part 1: #{chamber_height(chamber)}"

AVALANCHE = 1_000_000_000_000
@cache = {}
def projected_height(chamber, rock_index, gust_index)
  height = chamber_height(chamber)
  # because rocks and gusts repeat on a known cycle and blocks
  # are always dropped in the same spot relative to the top block,
  # we can cache a given spot, and know its count/height when we
  # see it again
  key = [rock_index % ROCKS.size, gust_index % GUSTS.size]
  if @cache[key]
    prev_rock_index, prev_height = @cache[key]
    # once we find an even multiple of our remaining rocks
    if ((AVALANCHE - rock_index) % (rock_index - prev_rock_index)).zero?
      # we have everything we need to plat a simple line ot the final goal y = mx + b style
      return height +                            # current height built so far
             (AVALANCHE - rock_index) /          # how many more rocks are there?
             (rock_index - prev_rock_index) *    # how many rocks are in this cached chunk?
             (height - prev_height)              # how far down does this cached chunk represent?
    end
  else
    @cache[key] = [rock_index, height]
  end
  false
end

rock_index = 0
gust_index = 0
chamber = Set.new
7.times { |x| chamber.add([x,0]) }

until (answer = projected_height(chamber, rock_index, gust_index))
  gust_index = add_rock(chamber, ROCKS[rock_index % 5], gust_index)
  rock_index += 1
end

puts "Part 2: #{answer}"
