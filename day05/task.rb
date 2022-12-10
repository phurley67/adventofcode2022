stacks = []
ARGF.each_line do |line|
  break if line.match(/1\s+2/)

  blocks = line.chomp.split(/.(.)..?/).reject { |l| l.empty? }
  stacks << blocks
end
stack_count = stacks.last.size - 1
stacks.each { |s| s[stack_count] = s[stack_count] }
stacks = stacks.transpose.map { |s| s.reject { |b| b.to_s.strip.empty? }}

ARGF.each_line do |line|
  if line.match(/move (\d+) from (\d+) to (\d+)/)
    count, from, to = Regexp.last_match.captures.map(&:to_i)

    bs = stacks[from - 1].shift(count)
    stacks[to.to_i - 1].prepend(*bs.reverse)
  end
end

puts stacks.flat_map { |s| s.first }.join
