maze = ARGF.each_line.map { |line| line.chomp.chars }

puts maze.map { |line| line.map { |ch| ch == 'S' ? 0 : (ch == 'E' ? 26 : ch.ord - 'a'.ord) }.join(' ') }.join("\n")
