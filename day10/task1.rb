x = 1
cycle = 0
signals = []
ARGF.each_line.map(&:split).each do |line|
  case line
  in ['addx', num]
    cycle += 1
    signals << [cycle, x] if ((cycle + 20) % 40).zero?
    cycle += 1
    signals << [cycle, x] if ((cycle + 20) % 40).zero?
    x += num.to_i
  in ['noop']
    cycle += 1
    signals << [cycle, x] if ((cycle + 20) % 40).zero?
  else
    raise :hell
  end
end

pp signals.map { _1 * _2}.sum
