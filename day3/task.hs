import Data.List
import Data.Char
import Data.Ix
import Text.Printf

split :: [a] -> ([a], [a])
split myList = splitAt (((length myList) + 1) `div` 2) myList

priority :: String -> Int
priority (c:cs)
   | inRange ('a','z') c = ord c - ord 'a' + 1
priority (c:cs) = ord c - ord 'A' + 26 + 1

common :: (String,String) -> String
common (s1,s2) = intersect s1 s2

task1 :: String -> Int
task1 s = sum $ map priority $ map common $ map split $ lines s

slice :: Int -> [a] -> [[a]]
slice _ [] = []
slice n xs = [first] ++ slice n second
    where 
        (first, second) = splitAt n xs

intersection:: (Eq a) => [[a]] -> [a]
intersection = foldr1 intersect

task2 :: String -> Int
task2 s = sum $ map priority $ map intersection $ slice 3 $ lines s

main = do
    body <- getContents
    printf "Round 1 total score %d\n" (task1 body)
    printf "Round 2 total score %d\n" (task2 body)
