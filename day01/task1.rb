puts ARGF.                        # Input file stream
  each_line.                      # get each line (will include newlines)
  map(&:to_i).                    # convert every line to an integer, blank lines will be zero
  slice_when { |e| e.zero? }.     # break the array up by elf -> [[12,2,0],[20,0],...]
  map(&:sum).                     # collapse each elf sub-array into a single value
  max
