def line_to_range(l)
  l.split(/\D+/).map(&:to_i).each_slice(2).map { |a| Range.new(*a) }
end

ranges = ARGF
         .each_line
         .map { |l| line_to_range(l) }

puts "Contained: #{ranges.count { |r1, r2| r1.cover?(r2) || r2.cover?(r1) }}"
puts "Overlapped: #{ranges.count { |r1, r2| r1.cover?(r2.first) || r2.cover?(r1.first) }}"
