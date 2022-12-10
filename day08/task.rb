def debug(trees)
  trees.each do |row|
    row.each do |tree|
      print tree.visible ? '*' : ' '
      print tree.height.to_s.ljust(2)
    end
    puts
  end
  puts
end

TreeStat = Struct.new(:height, :visible, :scores) { def initialize(height); super(height.to_i, false, []); end }

right = ARGF.each_line.map { |trees| trees.chomp.chars.map { |tree| TreeStat.new(tree.to_i) } }
down = right.transpose
left = right.map { |row| row.reverse }
up = down.map { |row| row.reverse }

[up,down,left,right].each do |trees|
  trees.each do |row|
    row.reduce([-1]) do |seen, tree|
      tree.visible ||= tree.height > seen.max
      tree.scores.push((seen.index { |prev_height| prev_height >= tree.height } || (seen.size - 2)) + 1)
      [tree.height] + seen
    end
  end
end

trees = right.flatten
trees.each { |t| pp t.scores }
puts trees.select(&:visible).count
puts trees.map { |t| t.scores.reduce(:*) }.max
