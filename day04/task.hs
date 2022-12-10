import Data.List
import Data.Char
import Text.Printf

data Range = Range Int Int deriving (Show)

covers :: [Range] -> Bool
covers [Range a b, Range x y] = a >= x && b <= y || x >= a && y <= b

overlap :: [Range] -> Bool
overlap [Range a b, Range x y] = covers [Range a b, Range x x] || covers [Range x y, Range a a]

splitWhen :: (Char -> Bool) -> String -> [String]
splitWhen cond xs = case break cond xs of 
  ("","") -> []
  (ls, "") -> [ls]
  (ls, x:rs) -> ls : splitWhen cond rs

slice :: Int -> [a] -> [[a]]
slice _ [] = []
slice n xs = [first] ++ slice n second
    where 
        (first, second) = splitAt n xs

count pred = length . filter pred

parseInput :: String -> [[Range]]
parseInput s = slice 2 $ map (\[a,b] -> Range a b) $ slice 2 $ map (read::String->Int) $ splitWhen (not . isDigit) s

task1 :: String -> Int
task1 s = count covers $ parseInput s

task2 :: String -> Int
task2 s = count overlap $ parseInput s

main = do
    body <- getContents
    printf "Round 1 total score %d\n" (task1 body)
    printf "Round 2 total score %d\n" (task2 body)

