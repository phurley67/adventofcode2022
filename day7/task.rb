dirs = {}
cdir = ['/']
size = 0
ARGF.each_line do |line|
  case line
  when /^\$ cd (.*)/
    ndir = $1
    case ndir
    when "/"
      cdir = ['/']
    when ".."
      cdir.pop
    else
      cdir << ndir
    end

  when /^\$ ls/
    raise "Yikes" if dirs[cdir.join('/')].to_i > 0
    dirs[cdir.join('/')] = 0

  when /^(\d+) (.*)/
    dirs[cdir.join('/')] += $1.to_i

  when /^dir (.*)/
    # puts "found dir #{$1}"

  else
    raise "Unknown: #{line.inspect}"
  end
end
if size > 0
  dirs[cdir.join('/')] = size
  size = 0
end

dirs.keys.sort_by { |k| k.size }.reverse.each do |dir|
  size = dirs[dir]
  dir = dir.split('/')
  if dir.size > 2
    dir.pop
    dirs[dir.join('/')] = dirs[dir.join('/')].to_i + size.to_i
  end
end

pp dirs
total = 70000000
free = total - dirs['/']
required = 30000000 - free

closest = '/'
cval = required - dirs['/']

dirs.each do |name, size|
  next if size < required
  if required - size > cval
    cval = required - size
    closest = name
  end
end
puts closest
puts dirs['closest']
puts required

