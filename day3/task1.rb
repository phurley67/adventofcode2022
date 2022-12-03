require 'set'

def priority(ch)
  # probably too cute, but a-z => 1-26, A-Z => 27-52
  ch.ord - (ch < 'a' ? 'A'.ord - 27 : 'a'.ord - 1)
end

items = ARGF.each_line.map(&:chomp).map do |line|
  part1,part2 = line.each_char.each_slice((line.size / 2.0).round).to_a

  set = Set.new(part1)
  part2.find { |ch| set.include?(ch) }
end

puts items.map { |i| priority(i) }.sum
