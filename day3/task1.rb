def priority(ch)
  # probably too cute, but a-z => 1-26, A-Z => 27-52
  ch.ord - (ch < 'a' ? 'A'.ord - 27 : 'a'.ord - 1)
end

items = ARGF.each_line.map(&:chomp).map do |line|
  line.chars.each_slice(line.size / 2).reduce(:&).first
end

puts items.map { |i| priority(i) }.sum
