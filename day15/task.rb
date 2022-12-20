def mdistance(points)
  sx,sy,bx,by = points.flatten
  (sx - bx).abs + (sy - by).abs
end

def build_ranges(input, target_row)
  input.map { |ps| [*ps, mdistance(ps)] }
       .filter { |(sx,sy),(bx,by),dist| ((sy - dist)..(sy + dist)).cover?(target_row) }
       .map { |(sx,sy),(bx,by),dist| [sx, dist, dist - (sy - target_row).abs] }
       .map { |sx, dist, width| [sx - width, sx + width] }
       .sort
end

TARGET_ROW = 2_000_000
# TARGET_ROW = 10
input = ARGF.read .split(/\n/) .map { |line| line.scan(/-?\d+/) .map(&:to_i) .each_slice(2).to_a }
ranges = build_ranges(input, TARGET_ROW)

count = 0
head = ranges.first.first
ranges.each do |x1, x2|
  if head < x1
    count += x2 - x1 + 1
    head = x2
  elsif head < x2
    count += x2 - head
    head = x2
  end
end
puts count

MAX_RANGE = 4_000_000
MAX_RANGE.times do |target_row|
  ranges = build_ranges(input, target_row)

  head = ranges.first.first
  ranges.each do |x1, x2|
    if head + 1 < x1
      puts target_row
      puts target_row + MAX_RANGE * (head + 1)
      exit
    elsif head < x2
      head = x2
    end
  end
end
