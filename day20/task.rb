def move(a,loops = 1)
  a = a.map.with_index { [_1, _2] }
  loops.times do
    size = a.size
    size.times do |index|
      index = a.find_index { |(_, start_pos)| index == start_pos }
      value,orig_pos = a.delete_at(index)
      new_index = (index + value) % (size - 1)
      a.insert(new_index, [value, orig_pos])
    end
  end
  a.map(&:first)
end

input = ARGF.read.scan(/-?\d+/).map(&:to_i)
decode = move(input)

# find the zero
zero = decode.find_index(0)
pp [1000,2000,3000].map { |n| decode[(n + zero) % decode.size] }.sum

KEY = 811589153
input = input.map { _1 * KEY }
decode = move(input, 10)
zero = decode.find_index(0)
pp [1000,2000,3000].map { |n| decode[(n + zero) % decode.size] }.sum
