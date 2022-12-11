Monkey = Struct.new(:items, :operation, :test, :on_true, :on_false, :activity) do
  def initialize(info)
    items, op, test, result1, result2 = *info

    operator, operand = *op.match(/(\S)\s(\S+)$/).captures
    operation = case [operator, operand]
                in ["+", "old"]
                  ->(n) { n + n }

                in ["*", "old"]
                  ->(n) { n * n }

                in ["+", num]
                  num = num.to_i
                  ->(n) { n + num }

                in ["*", num]
                  num = num.to_i
                  ->(n) { n * num }
                end

    test = test.gsub(/\D/,'').to_i
    result1 = result1.gsub(/\D/,'').to_i
    result2 = result2.gsub(/\D/,'').to_i
    super(items.scan(/\d+/).map(&:to_i), operation, test, result1, result2, 0)
  end
end

monkeys = ARGF.read.split(/Monkey \d:/).drop(1).map { |l| l.split("\n").drop(1) }
monkeys = monkeys.map { |monkey| Monkey.new(monkey) }

20.times do
  monkeys.each do |monkey|
    while (item = monkey.items.shift)
      monkey.activity += 1
      item = monkey.operation.call(item) / 3
      if (item % monkey.test).zero?
        monkeys[monkey.on_true].first.push(item)
      else
        monkeys[monkey.on_false].first.push(item)
      end
    end
  end
end

puts monkeys.map(&:activity).max(2).reduce(:*)