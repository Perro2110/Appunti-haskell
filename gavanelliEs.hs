double :: int -> int 
double x = x + x

quadruple :: Int -> Int
quadruple x = double(double x)

mfactorial :: Int -> Int
mfactorial n = foldr (*)1[1..n]

last1 :: [a] -> a 
last1 a = head(reverse(a))

last2 :: [a] -> a 
last2 a = a !! ((length a)-1)

last3 :: [a] -> a 
last3 (a:b) | (length b) /= 0 = last3 b
            | otherwise       = a

last4 :: [a] ->a  
last4 [a]   = a
last4 (a:b) = last4 b 

lengthh []    = 0 
lengthh (a:b) = 1 + lengthh b

concatena :: [a] -> [a] -> [a]
concatena a [] = a
concatena [] a = a
concatena (a:b) c = a:concatena b c

concatenaTutte :: [[a]] -> [a]
concatenaTutte [] = []
concatenaTutte (a:b) = a ++ concatenaTutte b

andlist :: [Bool] -> Bool
andlist [] = True 
andlist (a:b)   | a          = andlist b 
                | otherwise  = False

ispos :: [Int] -> Bool
ispos [] = True 
ispos (a:b) | a >= 0         = ispos b 
            | otherwise      = False

ispos2 :: [Int] -> Bool
ispos2 [] = True
ispos2 a | head(a) > 0 = ispos2 (tail(a))
         | otherwise   = False

ispos3 :: [Int] -> Bool
ispos3 a = if head a > 0 then ispos3 (tail a) else False

elin :: Int -> [Int] -> Bool
elin a [] = False
elin a (h:t)    | a == h    = True 
                | otherwise = elin a t 

elemento :: Int -> [Int] -> Int
elemento 0 (x:_)  = x
elemento n (_:xs) = elemento (n - 1) xs

inverti :: [a] -> [a]
inverti [] = []
inverti (l:t) = inverti t ++ [l]

addVect :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVect a b = (fst a + fst b , snd a + snd b) 

abs :: Int -> Int
abs n | n < 0     = -n
      | otherwise = n

safetail :: [a] -> [a]
safetail [] = []
safetail (a:b) = b

or :: Bool -> Bool -> Bool
or True _ = True 
or _ True = True 
or _ _ = False 

orInteligente :: Bool -> Bool -> Bool
orInteligente False False = False
orInteligente _ _ = True

and :: Bool -> Bool -> Bool
and True True = True 
and _ _ = False 

nsucc :: Char -> Int -> Char
nsucc c n = toEnum (fromEnum c + n)

cypher :: [Char] -> Int -> [Char]
cypher a num = map (\x -> nsucc x num) a 

cypher2 :: [Char] -> Int -> [Char]
cypher2 [] n = []
cypher2 (a:b) n = nsucc a n : cypher2 b n

quadList :: [Int] -> [Int]
quadList [] = []
quadList (a:b) = a*a : quadList b

qadListConMap :: [Int] -> [Int]
qadListConMap a = map (\x -> x*x) a

acronimo :: [String] -> [Char]
acronimo [] = []
acronimo (a:b) = head a : acronimo b

acronimoqithmap :: [String] -> [Char]
acronimoqithmap a = map (\x -> head x) a

lunghezze :: [[a]] -> [Int]
lunghezze [] = []
lunghezze (a:b) = (length a) : lunghezze b

lunghezzeconmappa :: [[a]] -> [Int]
lunghezzeconmappa a = map (\x -> length x) a


positivi :: [Int] -> [Int]
positivi [] = []
positivi (a:b) 
    | a > 0     = a : positivi b
    | otherwise = positivi b


positivii :: [Int] -> [Int]
positivii a = filter (\ x -> x > 0) a


corte :: [[Char]] -> [[Char]]
corte [] = []
corte (a:b) 
    | (length a) < 4 = a : corte b
    | otherwise      = corte b

cortee :: [[Char]] -> [[Char]]
cortee a = filter (\ x -> (length x) > 4) a

inn :: Char -> [Char] -> Bool
inn _ [] = False
inn x (a:b) 
    | x == a    = True
    | otherwise = inn x b

vocali :: [Char] -> [Char]
vocali [] = []
vocali (a:b) 
    | inn a "aeiou" = a : vocali b
    | otherwise    = vocali b


vocalii:: [Char] -> [Char]
vocalii a = filter(\ x -> inn x "aeiou")
