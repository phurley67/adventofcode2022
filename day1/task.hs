module Day1 where
import Text.Printf
import Data.Char (isSpace)
import Data.List (break,sort,reverse)

blank :: String -> Bool
blank s = all isSpace s

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith cond [] = []
splitWith cond xs = first : splitWith cond (safeTail rest)
    where
        (first, rest) = break cond xs
        -- Need this function to handle an empty list
        safeTail [] = []
        safeTail (_:ys) = ys

caloriesByElf :: String -> [[Int]]
caloriesByElf s =
    map (read::String->Int) <$> splitWith blank ( lines s )

totalCaloriesByElf :: String -> [Int]
totalCaloriesByElf s =
    reverse (sort (map sum (caloriesByElf s)))

task1 :: String -> Int
task1 s = head (totalCaloriesByElf s)

task2 :: String -> Int
task2 s = sum (take 3 (totalCaloriesByElf s))

main = do
    body <- getContents
    let ans1 = task1 body
    printf "Max elf calories %d\n" ans1

    let ans2 = task2 body
    printf "Top 3 elf calories %d\n" ans2
