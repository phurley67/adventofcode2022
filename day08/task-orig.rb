
def checkup(trees, row, col)
  height = trees[row][col]
  (row - 1).downto(0) do |r|
    return false if trees[r][col] >= height
  end
  true
end

def checkdown(trees, row, col)
  height = trees[row][col]
  (row + 1).upto(trees.size - 1) do |r|
    return false if trees[r][col] >= height
  end
  true
end

def checkleft(trees, row, col)
  height = trees[row][col]
  (col - 1).downto(0) do |c|
    return false if trees[row][c] >= height
  end
  true
end

def checkright(trees, row, col)
  height = trees[row][col]
  (col + 1).upto(trees[row].size - 1) do |c|
    return false if trees[row][c] >= height
  end
  true
end

def is_visible?(trees, row, col)
  checkup(trees, row, col) || checkdown(trees, row, col) || checkleft(trees, row, col) || checkright(trees, row, col)
end

trees = ARGF.readlines(chomp: true).map(&:chars)
visible = trees.clone.map(&:clone) #deep clone

1.upto(trees.size - 2) do |col|
  1.upto(trees[col].size - 2) do |row|
    visible[row][col] = is_visible?(trees, row, col)
  end
end

pp visible
pp visible.map { |r| r.count { |v| v } }
pp visible.map { |r| r.count { |v| v } }.sum
