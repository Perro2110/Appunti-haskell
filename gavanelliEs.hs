double :: Int -> Int 
double x = x + x

quadruple :: Int -> Int
quadruple x = double(double x)

mfactorial :: Int -> Int
mfactorial n = foldr (*) 1 [1..n]

last1 :: [a] -> a 
last1 a = head(reverse(a))

last2 :: [a] -> a 
last2 a = a !! ((length a)-1)

last3 :: [a] -> a 
last3 (a:b) | (length b) /= 0 = last3 b
            | otherwise       = a

last4 :: [a] -> a  
last4 [a]   = a
last4 (a:b) = last4 b 

lengthh []    = 0 
lengthh (a:b) = 1 + lengthh b

concatena :: [a] -> [a] -> [a]
concatena [] b    = b
concatena (a:b) c = a : concatena b c

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
ispos3 [] = True
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
positivii a = filter (\x -> x > 0) a

corte :: [[Char]] -> [[Char]]
corte [] = []
corte (a:b) 
    | (length a) < 4 = a : corte b
    | otherwise      = corte b

cortee :: [[Char]] -> [[Char]]
cortee a = filter (\x -> length x < 4) a

inn :: Char -> [Char] -> Bool
inn _ [] = False
inn x (a:b) 
    | x == a    = True
    | otherwise = inn x b

vocali :: [Char] -> [Char]
vocali [] = []
vocali (a:b) 
    | inn a "aeiou" = a : vocali b
    | otherwise     = vocali b

volaiconfilter :: [Char] -> [Char]
volaiconfilter a = filter (\x -> inn x "aeiou") a

quadMat :: [[Int]] -> [[Int]]
quadMat [] = []
quadMat a = map(\x -> map(\y -> y * y) x) a 

eclama :: [String] -> [String]
eclama [] = []
eclama (a:b) = reverse('!':reverse(a)):eclama b

pollo :: [String] -> [String]
pollo a = map (\x -> reverse('!':reverse(x))) a

verificaPari :: [Int] -> [Bool]
verificaPari a = map (\ x -> mod x 2 == 0) a

incrList :: [Int] -> [Int]
incrList a = map (\x -> x + 1) a

-- Il currying in Haskell è il meccanismo per cui ogni funzione accetta un solo
--  argomento alla volta, restituendo una nuova funzione per ogni argomento 
-- successivo.

-- Moltiplicazione
multiply :: Int -> Int -> Int
multiply x y = x * y

double2 = multiply 2
triple2 = multiply 3

-- Con le funzioni di lista
addOne = map (+1)

greaterThan5 = filter (>5)

-- provo a riscrivere gravity usando il currying
-- Write the function gravity that, given a mass
-- m1, a distance d, and a mass m2, computes the gravitational force
gravity :: Float -> Float -> Float -> Float  
gravity m1 d m2 = ((6.67 * 1/10^(11)) * (m1 * m2)) / (d * d)
-- Write the function earthGravity that, given a mass and a distance, computes 
-- the gravitational force of the Earth on the mass
earthGravity :: Float -> Float -> Float 
earthGravity = gravity (5.972 * 10^24)

-- Write a function earthGravitySurface that
-- computes the weight of a mass on the surface of
-- the Earth
earthGravitySurface = earthGravity 6371000

log2 :: Float -> Float
log2 = logBase 2

-- Sections
rec :: Float -> Float
rec = (1/)

-- uso della zip

corrispondenze listaA listaB = filter (\(x, y) -> x == y) (zip listaA listaB)


-------------------------------------------------------------------------------
-- foldr (associativita a destra) e foldl 
-------------------------------------------------------------------------------

-- sum []    = 0  
-- sum (a:b) = a + b 

-- prod []    = 1  
-- prod (a:b) = a * b 

foldrr f x [] = x 
foldrr f x (a:b) = f a (foldrr f x b)

sumf a = foldr (+) 0 a 

prod a = foldr (*) 1 a

----------------
s :: [Int] -> Int
s = foldr (+) 0

p :: [Int] -> Int
p = foldr (*) 1

o :: [Bool] -> Bool
o = foldr (||) False

aa :: [Bool] -> Bool
aa = foldr (&&) True

--                         x prende elemento a 
--                           n prende lo 0 
lengthfoldosa a = foldr (\ x n -> n + 1) 0 a

--  Vocali
vocalii :: [Char] -> Int 
vocalii a = foldr (\ x n -> if (elem x "aeiou") then n + 1 else n) 0 a

-- Controllo password
-- 1. Lunghezza maggiore di 15
-- 2. Almeno una lettera minuscola
-- 3. Almeno una lettera maiuscola
-- 4. Almeno un numero

checckers_1 :: [Char] -> Bool
checckers_1 a 
            | (foldr (\ x n -> n + 1) 0 a) > 15 = True 
            | otherwise = False  


checckers_2 :: [Char] -> Bool
checckers_2 a 
            | (foldr (\ x n -> if (elem x ['A'..'Z']) then n + 1 else n) 0 a) > 1 = True 
            | otherwise = False 

checckers_3 :: [Char] -> Bool
checckers_3 :: [Char] -> Bool
checckers_3 a 
            | (foldr (\ x n -> if (elem x ['a'..'z']) then n + 1 else n) 0 a) > 1 = True 
            | otherwise = False 

checckers_4 :: [Char] -> Bool
checckers_4 :: [Char] -> Bool
checckers_4 a 
            | (foldr (\ x n -> if (elem x ['1'..'9']) then n + 1 else n) 0 a) > 1 = True 
            | otherwise = False 

funandmap :: [(a -> Bool)] -> a -> Bool           
funandmap [] b = True
funandmap (a:at) b = a b && funandmap at b 

checker :: [Char] -> Bool
checker a = funandmap [checckers_4,checckers_3,checckers_2,checckers_1] a

checker_lite :: [Char] -> Bool
checker_lite a 
    | ((foldr (\ x n -> n + 1) 0 a) > 15) && (foldr (\ x n -> elem x ['a'..'z'] || n) False a) = True 
    | otherwise = False


checker_litee :: [Char] -> Bool
checker_litee a =  ((foldr (\ x n -> n + 1) 0 a) > 15) &&
                   (foldr (\ x n -> elem x ['a'..'z'] || n) False a) &&
                   (foldr (\ x n -> elem x ['A'..'Z'] || n) False a) &&
                   (foldr (\ x n -> elem x ['0'..'9'] || n) False a) 