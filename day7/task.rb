class Path < Array
  def initialize(cwd='/')
    super cwd.split('/').reject(&:empty?)
  end

  def to_s
    '/' + join('/')
  end
end
cwd = Path.new

tree = {}
ARGF.each_line.map(&:split).each do |line|
  case line
  in %w[$ cd /]
    cwd.clear
  in %w[$ cd ..]
    cwd.pop
  in ['$', 'cd', name]
    cwd << name
  in ['$', 'ls']
    tree[cwd.to_s] = 0
  in ['dir', name]
    # do nothing
  in [size, name]
    tree[cwd.to_s] += size.to_i
  else
    raise :hell
  end
end

tree.keys.sort_by { -_1.size }.each do |dir|
  size = tree[dir]
  if (dir = Path.new(dir)).pop
    tree[dir.to_s] += size
  end
end

print "Task 1: "
puts tree.values.reject { _1 >= 100_000 }.sum

FREE = 70_000_000 - tree['/']
REQUIRED = 30_000_000 - FREE
print "Task 2: "
puts tree.values.reject {_1 < REQUIRED }.min