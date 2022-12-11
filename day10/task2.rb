x = 1
cycle = 0
signals = []
ARGF.each_line.map(&:split).each do |line|
  case line
  in ['addx', num]
    signals << [cycle, x]
    cycle += 1
    signals << [cycle, x]
    cycle += 1
    x += num.to_i
  in ['noop']
    signals << [cycle, x]
    cycle += 1
  else
    raise :hell
  end
end

signals.each_slice(40) do | line|
  puts line.map { |clock, reg| ((clock % 40) - reg).abs < 2 ? "\u2588" : ' ' }.join
end
