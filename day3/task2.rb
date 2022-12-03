def priority(ch)
  # probably too cute, but a-z => 1-26, A-Z => 27-52
  ch.ord - (ch < 'a' ? 'A'.ord - 27 : 'a'.ord - 1)
end

groups = ARGF.each_line.each_slice(3).map { |group|
  group.map(&:chars).reduce(:&).first
}

puts groups.map { |g| priority(g) }.sum
