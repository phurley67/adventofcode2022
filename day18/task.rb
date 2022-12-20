def each_edge(x,y,z)
  [[ x + 1, y, z ],
  [ x, y + 1, z ],
  [ x - 1, y, z ],
  [ x , y - 1, z ],
  [ x, y, z + 1 ],
  [ x, y, z - 1 ]]
end

cubes = ARGF.each_line.map { |l| l.scan(/\d+/).map(&:to_i) }

exposed = {}
count = 0
cubes.each do |cube|
  exposed[[*cube]] = each_edge(*cube).count do |x, y, z|
    if exposed.include?([x,y,z])
      exposed[[x,y,z]] -= 1
      false
    else
      true
    end
  end
end
pp exposed.values.sum

def bfs_fill(cubes)
  count = 0
  seen = {}

  # assume about square
  min, max = cubes.keys.flatten.minmax
  min -= 1
  max += 1
  queue = [[min, min, min]]
  until queue.empty?
    pos = queue.shift
    x,y,z = *pos
    next if x < min || x > max
    next if y < min || y > max
    next if z < min || z > max
    next if seen[pos]

    seen[pos] = true

    each_edge(*pos).each do |p|
      count += 1 if cubes[p]
      queue << p unless cubes[p]
    end
  end
  count
end

puts bfs_fill(exposed)
