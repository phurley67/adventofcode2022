top3_calories_by_elf = ARGF.      # Input file stream
  each_line.                      # get each line (will include newlines)
  map(&:to_i).                    # convert every line to an integer, blank lines will be zero
  slice_when { |e| e.zero? }.     # break the array up by elf -> [[12,2,0],[20,0],...]
  map(&:sum).                     # collapse each elf sub-array into a single value
  max(3)                          # top 3 elves calories already sorted

# using sort.reverse first/take here as max would repeat that relatively expensive work
# if you knew you never needed more than 3, max(3).sort.reverse might be even better

puts "Max calories 1 elf #{top3_calories_by_elf.first}"
puts "Max calories 3 elves #{top3_calories_by_elf.sum}"
