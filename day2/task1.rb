WIN = 6
TIE = 3
LOSS = 0

ROCK = 1
PAPER = 2
SCISSOR = 3

# Originally I just wrote this table
SCORE_KEY = {
  "A X" => TIE  + ROCK,
  "A Y" => WIN  + PAPER,
  "A Z" => LOSS + SCISSOR,
  "B X" => LOSS + ROCK,
  "B Y" => TIE  + PAPER,
  "B Z" => WIN  + SCISSOR,
  "C X" => WIN  + ROCK,
  "C Y" => LOSS + PAPER,
  "C Z" => TIE  + SCISSOR
}

def score(game)
  if game.match(/\A[A-C] [X-Z]/) 
    # grab the low three bits of each ascii value
    p1 = game[0].ord[0..2]
    p2 = game[2].ord[0..2]

    # Yikes!
    # subtracting the p2 from p1 mod 3 gives a 0,1,2 for W,T,L respectively -- found through fiddling
    # 2 - that value changes W,T,L to 2,1,0
    # * 3 - that value changes W,T,L to 6,3,0
    # p2 will be 0,1,2 for R,P,S
    # p2 + 1 will be 1,2,3 for R,P,S
    # add it together and you get the correct score
    (2 - ((p1 - p2) % 3)) * 3 + p2 + 1
  end
end

# I sort of like the table approach, but if you wanted 
# something more algorithmic -- for example if the 
# table was too big to maintain, you could still use
# a hash to memoize the work like so
# 
# SCORE_KEY = Hash.new { |h,k| h[k] = score(k) }
#
# or just 
#
# puts ARGF.each_line.sum { |k| score(k) }

puts ARGF.each_line.sum { |k| SCORE_KEY[k.chomp] }

