WIN = 6
TIE = 3
LOSS = 0

ROCK = 1
PAPER = 2
SCISSOR = 3

SCORE_KEY = {
  "A X" => LOSS + SCISSOR,
  "A Y" =>  TIE +    ROCK,
  "A Z" =>  WIN +   PAPER,
  "B X" => LOSS +    ROCK,
  "B Y" =>  TIE +   PAPER,
  "B Z" =>  WIN + SCISSOR,
  "C X" => LOSS +   PAPER,
  "C Y" =>  TIE + SCISSOR,
  "C Z" =>  WIN +    ROCK
}

def score(game)
  if game.match(/\A[A-C] [X-Z]/) 
    # grab the low three bits of each ascii value
    p1 = game[0].ord[0..2]
    p2 = game[2].ord[0..2]

    # Yikes!
    # p2 will be 0,1,2 for L,T,W
    # p2 * 3 will be 0,3,6
    # more fiddling, finds (p1 + p2 + 1) % 3 + 1, gives 1,2,3 for R,P,S played to win based on X,Y,Z being L,T,W
    # -- probably should have used game[2].ord - 'W'.ord...
    p2 * 3 + ((p1 + p2 + 1) % 3) + 1
  end
end

#puts ARGF.each_line.sum { |k| score(k) }
puts ARGF.each_line.sum { |k| SCORE_KEY[k.chomp] }

