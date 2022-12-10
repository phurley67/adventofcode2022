def unique_pos(msg, len)
  msg
    .each_cons(len)
    .find_index { |a| a.uniq.size == len } + len
end

message = ARGF.read.chars
puts "Task 1 #{uniqpos(message, 4)}"
puts "Task 2 #{uniqpos(message, 14)}"
