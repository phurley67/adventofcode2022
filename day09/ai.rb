# Parse the input string into a list of (direction, distance) tuples
directions = input_string.split.map { |token| [token[0], token[1..-1].to_i] }

# Initialize the head and tail positions
head_row = 0
head_col = 0
tail_row = 0
tail_col = 0

# Loop over each direction and distance in the input
directions.each do |direction, distance|
  # Move the head in the specified direction
  if direction == "U"
    head_row -= distance
  elsif direction == "D"
    head_row += distance
  elsif direction == "L"
    head_col -= distance
  elsif direction == "R"
    head_col += distance
  end

  # Update the tail position if necessary
  if head_row - tail_row).abs == 2 || (head_col - tail_col).abs == 2
  # If the head is two steps up, down, left, or right from the tail,
  # move the tail one step in the same direction as the head
  if head_row < tail_row
    tail_row -= 1
  elsif head_row > tail_row
    tail_row += 1
  elsif head_col < tail_col
    tail_col -= 1
  elsif head_col > tail_col
    tail_col += 1
  end
  elsif head_row != tail_row && head_col != tail_col
    # If the head and tail aren't touching and aren't in the same row or column,
    # move the tail one step diagonally to keep up with the head
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
end

# Print the final position of the tail
puts "Tail: (#{tail_row}, #{tail_col})"
