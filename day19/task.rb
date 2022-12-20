Material = Struct.new(:ore, :clay, :obsidian, :geodes) do
  def initialize(o=0, c=0, ob=0, g=0)
    super(o,c,ob,g)
  end

  def -(other)
    Material.new(ore - other.ore, clay - other.clay, obsidian - other.obsidian, geodes - other.geodes)
  end

  def +(other)
    Material.new(ore + other.ore, clay + other.clay, obsidian + other.obsidian, geodes + other.geodes)
  end

  def can_build(factory)
    ore >= factory.ore &&
      clay >= factory.clay &&
      obsidian >= factory.obsidian
  end
end

Blueprint = Struct.new(:id, :ore, :clay, :obsidian, :geodes) do
  def initialize(print)
    super(
      print[0],
      Material.new(print[1]),
      Material.new(print[2]),
      Material.new(print[3], print[4]),
      Material.new(print[5], 0, print[6])
    )
  end

  def each
    [ore, clay, obsidian, geodes]
  end
end

def solve(bprint, time)
  best = 0
  maxOre = bprint.each.map(&:ore).max
  # state is materials, robots, time
  state = [Material.new, Material.new(1), time]
  queue = [state]
  cache = {}
  until queue.empty?
    state = queue.shift

    resources, robots, time = *state
    best = [best, resources.geodes].max
    next if time.zero?

    # pp ['check', time, resources, robots]
    # never bother building more robots than we can use in one turn
    robots.ore = [maxOre, robots.ore].min
    robots.clay = [bprint.obsidian.clay, robots.clay].min
    robots.obsidian = [bprint.geodes.obsidian, robots.obsidian].min

    # don't bother collecting more materials than we can use before time runs out
    resources.ore = [time * maxOre - robots.ore * (time - 1), resources.ore].min
    resources.clay = [time * bprint.obsidian.clay - robots.clay * (time - 1), resources.clay].min
    resources.obsidian = [time * bprint.geodes.obsidian - robots.obsidian * (time - 1), resources.obsidian].min

    state = [resources, robots, time]
    next if cache[state]
    cache[state] = true

    queue << [resources + robots, robots, time - 1]
    if resources.can_build(bprint.ore)
      queue << [resources + robots - bprint.ore, robots + Material.new(1), time - 1]
    end
    if resources.can_build(bprint.clay)
      queue << [resources + robots - bprint.clay, robots + Material.new(0,1), time - 1]
    end
    if resources.can_build(bprint.obsidian)
      queue << [resources + robots - bprint.obsidian, robots + Material.new(0, 0, 1), time - 1]
    end
    if resources.can_build(bprint.geodes)
      queue << [resources + robots - bprint.geodes, robots + Material.new(0, 0, 0, 1), time - 1]
    end
  end
  best
end

input = ARGF.each_line.map { |l| l.scan(/\d+/).map(&:to_i) }.map {|p| Blueprint.new(p) }
part1 = input.map { |bprint| solve(bprint, 24) }.map.with_index { |g,i| g * (i + 1) }.sum
puts "Part 1: #{part1}"
part2 = input.take(3).map { |bprint| solve(bprint, 32) }.reduce(:*)
puts "Part 2: #{part2}"
