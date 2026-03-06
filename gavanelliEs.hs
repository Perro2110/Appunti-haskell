
double :: Int -> Int 
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
ispos3 a = if head a > 0 then ispos3 (tail a)
           else False

elin :: Int -> [Int] -> Bool
elin a [] = False
elin a (h:t)    | a == h    = True 
                | otherwise = elin a t 

elemento :: Int -> [Int] -> Int
elemento 0 (x:_)  = x
elemento n (_:xs) = elemento (n - 1) xs

elementoneg :: Int -> [Int] -> Int
elementoneg 0 (x:_)  = x
elementoneg n a | n > 0     = elementoneg (n - 1) tail(a)
                | otherwise = elementoneg (-n) tail(a)