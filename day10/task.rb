trace = ARGF.each_line.map(&:split).reduce([1,1]) do |trace, cmd|
  trace.push(trace.last)  # no-op and addx both do the same thing for the first clock cycle
  trace.push(trace.last + cmd.last.to_i) if cmd.first == 'addx'
  trace
end

pp trace.filter_map.with_index { |x, clock| x * clock if clock % 40 == 20}.sum

# drop cycle 0
crt = trace.drop(1).each_slice(40).map do |line|
  line.map.with_index { |x,pos| (pos - x).abs < 2 ? "\u2588" : " " }.join
end

puts crt.join("\n")
