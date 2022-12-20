# frozen_string_literal: true

require 'json'

def comp(a, b)
  case [a, b]
  in [Integer, Integer]
    a <=> b
  in [[x, *as], [^x, *bs]]
    comp(as, bs)
  in [[x, *_], [y, *_]]
    comp(x, y)
  in [Array, Array]
    a.size <=> b.size
  in [Array, Integer]
    comp(a, [b])
  in [Integer, Array]
    comp([a], b)
  end
end

input = ARGF.read   # read in the entire input file

part1 = input.split("\n\n").map do |pair|            # break input into pairs [["[1]","[2]"],...]
  pair.split("\n").map { |s| JSON.parse(s) }         # convert string expr into values [[[1],[2]],...]
end

puts part1.map
          .with_index { [comp(*_1), _2 + 1] }        # compare each pair, save result with index
          .reject { |a, _| a >= 0 }                  # remove any pairs that are out of order
          .sum { _2 }                                # sum up just the indices

sentinels = [[[2]], [[6]]]
part2 = input
        .each_line                                 # all the lines
        .reject { _1.chomp.empty? }                # but not the blank ones
        .map { JSON.parse(_1) } +                  # convert strings to ruby values
        sentinels
part2 = part2.sort { comp(_1, _2) }                # sort the whole thing

puts sentinels.map { part2.index(_1) + 1}   # find location of each sentinel
  .reduce(:*)                                                   # multiply together
