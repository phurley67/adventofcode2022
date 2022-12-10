input_string = ARGF.read
# Parse the input string into a list of (direction, distance) tuples
directions = input_string.split.each_slice(2).map { |token| [token[0], token[1].to_i] }

# Initialize the head and tail positions
head_row = 0
head_col = 0
tail_row = 0
tail_col = 0

trace = {}
# Loop over each direction and distance in the input
directions.each do |direction, distance|
  distance.times do
    # Move the head in the specified direction
    if direction == "U"
      head_row -= 1
    elsif direction == "D"
      head_row += 1
    elsif direction == "L"
      head_col -= 1
    elsif direction == "R"
      head_col += 1
    end

    # Update the tail position if necessary
    if (head_row - tail_row).abs == 2 || (head_col - tail_col).abs == 2
      # If the head is two steps up, down, left, or right from the tail,
      # move the tail one step in the same direction as the head
      if head_row < tail_row
        tail_row -= 1
      elsif head_row > tail_row
        tail_row += 1
      end
      if head_col < tail_col
        tail_col -= 1
      elsif head_col > tail_col
        tail_col += 1
      end
    end
    trace[[tail_col,tail_row]] = 1
  end
end

# Print the final position of the tail
puts "Tail: (#{tail_row}, #{tail_col})"
puts trace.size