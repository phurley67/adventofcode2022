Monkey = Struct.new(:items, :operation, :test, :on_true, :on_false, :activity) do
  class << self
    attr_accessor :barrel, :divisor
  end

  def initialize(info)
    items, op, test, result1, result2 = *info

    operator = op.scan(/[*+]/).first.to_sym
    operand = op.scan(/\d+$/).map(&:to_i).first
    operation = ->(n) { n.send(operator, operand || n) }
    test = test.gsub(/\D/, '').to_i
    result1 = result1.gsub(/\D/, '').to_i
    result2 = result2.gsub(/\D/, '').to_i
    super(items.scan(/\d+/).map(&:to_i), operation, test, result1, result2, 0)
  end

  def process
    while (item = items.shift)
      self.activity += 1
      item = operation.call(item) % Monkey.divisor
      Monkey.barrel[(item % test).zero? ? on_true : on_false].first.push(item)
    end
  end
end

Monkey.barrel = ARGF
            .read
            .split(/Monkey \d:/)
            .drop(1)
            .map { |l| Monkey.new(l.split("\n").drop(1)) }

# only need to keep track if the worry is divisible by
# largest of our divisors, so it is always safe to
# modulo by the lcm of all of our divisors
Monkey.divisor = Monkey.barrel.map { |m| m.test }.reduce(:lcm)

10000.times do
  Monkey.barrel.each { |m| m.process }
end

puts Monkey.barrel.map(&:activity).max(2).reduce(:*)