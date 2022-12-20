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
ranges.each do |x,y|
  if head < x
    count += y - x + 1
    head = y
  elsif head < y
    count += y - head
    head = y
  end
end
puts count

__END__
4000001.timess do |target_row|
  ranges = []
  input.each
end

	for target_row in range(0, 4000000):
		ranges = list()
		
		for sx, sy, bx, by in data:
			L1 = abs(sx - bx) + abs(sy - by)
			
			if (sy - L1) <= target_row <= (sy + L1):
				width = L1 - abs(sy - target_row)
				ranges.append((sx - width, sx + width, ))
		
		ranges.sort()
		
		head = ranges[0][0]
		for x, y in ranges:
			if head+1 < x:
				return target_row+4000000*(head+1)
			else:
				if head < y:
					head = y

print(heck())
