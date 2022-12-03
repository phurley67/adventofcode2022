require 'set'

def priority(ch)
  # probably too cute, but a-z => 1-26, A-Z => 27-52
  ch.ord - (ch < 'a' ? 'A'.ord - 27 : 'a'.ord - 1)
end

groups = ARGF.each_line.each_slice(3).map { |e1,e2,e3|
  e1.each_char.to_a.intersection(e2.each_char.to_a).intersection(e3.each_char.to_a).first
}

puts groups.map { |g| priority(g) }.sum
