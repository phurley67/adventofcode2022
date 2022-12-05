s = ARGF.read
if s.match(/(.*)^\s+1.*?$(.*)/m)
  stackdef = $1
  moves = $2

  stacks = stackdef.each_line.map do |line|
    line.chomp.chars.each_slice(4).to_a.map { |a| a.join.strip[1] }
  end
  stack_count = stacks.max { |a| a.size }.size
  stacks.each do |s|
    s[stack_count - 1] = s[stack_count - 1]
  end
  stacks = stacks.transpose.map { |s| s.compact }

  moves.each_line do |line|
    next if line.strip.empty?
    nums = line.split(/\D+/)
    nums.shift
    count, from, to = *nums

    bs = stacks[from.to_i - 1].shift(count.to_i)
    # part 1 with the reverse, part 2 without
    # stacks[to.to_i - 1].prepend(*bs.reverse)
    stacks[to.to_i - 1].prepend(*bs)

    pp nums
    pp stacks
  end

  puts stacks.flat_map { |s| s.first }.join
end
