module Day1 where
import Text.Printf
import Data.Char (isSpace)
import Data.List (break,sort,reverse)

data Move = Rock | Paper | Scissor | InvalidMove deriving (Show)

toMove :: String -> Move
toMove "A" = Rock
toMove "B" = Paper
toMove "C" = Scissor
toMove "X" = Rock
toMove "Y" = Paper
toMove "Z" = Scissor
toMove _ = InvalidMove

gameString :: String -> [[Move]]
gameString s = 
   map (\s -> [toMove (take 1 s), toMove (drop 2 s)]) (lines s)

score :: [Move] -> Int
score (Rock:Paper:ms) = 6 + 2
score (Paper:Scissor:ms) = 6 + 3
score (Scissor:Rock:ms) = 6 + 1
score (Rock:Rock:ms) = 3 + 1
score (Paper:Paper:ms) = 3 + 2
score (Scissor:Scissor:ms) = 3 + 3
score (Rock:Scissor:ms) = 3
score (Paper:Rock:ms) = 1
score (Scissor:Paper:ms) = 2
score _ = error "Hell"

task1 :: String -> Int
task1 s = sum (score <$> gameString s)

data Outcome = Win | Loss | Tie | InvalidOutcome deriving (Show)
toOutcome :: String -> Outcome
toOutcome "X" = Loss
toOutcome "Y" = Tie
toOutcome "Z" = Win
toOutcome _ = InvalidOutcome

scoreOutcome :: (Move,Outcome) -> Int
scoreOutcome (Rock,Loss) = 0 + 3
scoreOutcome (Rock,Tie) = 3 + 1
scoreOutcome (Rock,Win) = 6 + 2
scoreOutcome (Paper,Loss) = 0 + 1
scoreOutcome (Paper,Tie) = 3 + 2
scoreOutcome (Paper,Win) = 6 + 3
scoreOutcome (Scissor,Loss) = 0 + 2
scoreOutcome (Scissor,Tie) = 3 + 3
scoreOutcome (Scissor,Win) = 6 + 1
scoreOutcome _ = error "Hell"

data GameState = Move | Outcome
gameOutcomeString :: String -> [(Move,Outcome)]
gameOutcomeString s = 
   map (\s -> (toMove (take 1 s), toOutcome (drop 2 s))) (lines s)

task2 :: String -> Int
task2 s = sum (scoreOutcome <$> gameOutcomeString s)

main = do
    body <- getContents

    let ans1 = task1 body
    printf "Round 1 total score %d\n" ans1

    let ans2 = task2 body
    printf "Round 2 total score %d\n" ans2
