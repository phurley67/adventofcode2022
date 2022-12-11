Monkey = Struct.new(:items, :operation, :test, :on_true, :on_false, :activity) do
  def initialize(info)
    items, op, test, result1, result2 = *info

    operator = op.scan(/[*+]/).first.to_sym
    operand = op.scan(/\d+$/).map(&:to_i).first
    operation = ->(n) { n.send(operator, operand || n) }
    test = test.gsub(/\D/,'').to_i
    result1 = result1.gsub(/\D/,'').to_i
    result2 = result2.gsub(/\D/,'').to_i
    super(items.scan(/\d+/).map(&:to_i), operation, test, result1, result2, 0)
  end
end

monkeys = ARGF.read.split(/Monkey \d:/).drop(1).map { |l| l.split("\n").drop(1) }
monkeys = monkeys.map { |monkey| Monkey.new(monkey) }

# only need to keep track if the worry is divisible by
# largest of our divisors, so it is always safe to
# modulo by the lcm of all of our divisors
lcm = monkeys.map { |m| m.test }.reduce(:lcm)

10000.times do
  monkeys.each do |monkey|
    while (item = monkey.items.shift)
      monkey.activity += 1
      item = monkey.operation.call(item) % lcm
      if (item % monkey.test).zero?
        monkeys[monkey.on_true].first.push(item)
      else
        monkeys[monkey.on_false].first.push(item)
      end
    end
  end
end

puts monkeys.map(&:activity).max(2).reduce(:*)