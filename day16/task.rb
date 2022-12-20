input = ARGF.each_line.map { |l| l.match(/Valve (..) has flow rate=(\d+); .*valve.(.*)/)[1..-1] }
            .map { |valve, flow, path| [valve, flow.to_i, path.scan(/[A-Z]+/)] }

@graph = {}
@rates = {}
@node_index = Hash.new { |h, k| h[k] = h.size }  # handy hash that provides a unique index for a key
input.each do |valve, flow, path|
  @rates[valve] = flow
  @graph[valve] = path
  @node_index[valve] if flow.positive?
end

GOOD_VALVES = @node_index.size
ALL_MASK = (1 << GOOD_VALVES) - 1
# Bit map of only valves with flow rate > 0 -- we ignore the zeros
# cache of valves / timestamp / bit mask of open valves => best flow for that set at that time (1 is off, 0 is on)
@cache = Hash.new { |h, k| h[k] = Array.new(31) { Array.new(ALL_MASK + 1) } }

# pretty much a memoized depth first, time boxed walk of the tree
def step(valve, time, mask)
  # max depth of search saves us from a chunk of the n! explosion
  return 0 if time.zero?

  # have we been here at this exact same state before? (valve, time, and open mask)
  unless @cache[valve][time][mask]
    # depth first search which of the next possible branches would be best
    best = @graph[valve].map { |next_valve| step(next_valve, time - 1, mask) }.max
    valve_id = @node_index[valve]

    # is this valve worth opening? (non-zero rate) and not already open?
    if valve_id < GOOD_VALVES && mask[valve_id] == 1
      # "open" the valve, calculate its flow for the remaining time and search
      best = [best, step(valve, time - 1, mask - (1 << valve_id)) + @rates[valve] * (time - 1)].max
    end
    @cache[valve][time][mask] = best
  end

  @cache[valve][time][mask]
end

# With the optimizations this is fastish (~2 sec)
puts "Part1: #{step("AA", 30, ALL_MASK)}"

# Part 2 is brute forced from part 1, but by remember every state up to here
# despite the large number of situations the cache helps out quite a bit
part2 = (ALL_MASK + 1).times.map do |mask|
  # me and my elephant buddy, will try the elephant with every possible combination
  # of valves each - from the case where I attempt to get every valve and
  # the elephant gets non, to the opposite. Could try to be smarter here; however,
  # again the cache will save me.
  step('AA', 26, ALL_MASK - mask) + step('AA', 26, mask)
end.max
puts "Part2: #{part2}"
