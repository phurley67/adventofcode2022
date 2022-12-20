require 'aoclib'

def move(a)
  while index = a.find_index { |(val,moved)| !moved }
    # pp index
    # pp a.map(&:first)
    val,_ = a.delete_at(index)

    # pp [index, val, a.size]
    new_index = (index + val) % a.size
    # puts "Move #{val} from #{index} to #{new_index}"
    if new_index.zero?
      a.push([val, true])
    else
      a.insert(new_index, [val, true])
    end
    # pp a.map(&:first)
  end
end

input = ARGF.read.scan(/-?\d+/).map { |i| [i.to_i, false] }
move(input)
decode = input.map(&:first)
pp decode
zero = decode.find_index(0)
decode = decode[zero..-1] + decode[0...zero]
pp decode

pp [1000,2000,3000].map { |n| decode[n % decode.size] }.sum