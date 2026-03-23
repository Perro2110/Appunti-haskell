# 📘 Haskell — Appunti e Concetti Fondamentali

Riassunto spiegazioni e esempi di codice per i concetti chiave di Haskell.
Codice completo presente in conoscenze.hs

---

## 1. Funzioni di Base

In Haskell ogni funzione ha una **firma dei tipi** e una **definizione**. La sintassi è pulita e dichiarativa.

```haskell
double :: Int -> Int
double x = x + x

quadruple :: Int -> Int
quadruple x = double(double x)
```

Le funzioni sono **pure**: dato lo stesso input, restituiscono sempre lo stesso output, senza effetti collaterali.

---

## 2. Pattern Matching

Il **pattern matching** permette di definire comportamenti diversi in base alla struttura dell'argomento. È uno dei meccanismi più potenti di Haskell.

```haskell
-- Su valori specifici
or :: Bool -> Bool -> Bool
or True _ = True
or _ True = True
or _ _    = False

-- Su liste
last4 :: [a] -> a
last4 [a]   = a
last4 (a:b) = last4 b
```

Il simbolo `_` è un **wildcard**: indica che il valore non ci interessa.

---

## 3. Guardie (Guards)

Le **guardie** sono condizioni booleane che selezionano quale ramo eseguire. Si usano con `|`.

```haskell
abs :: Int -> Int
abs n | n < 0     = -n
      | otherwise = n

last3 :: [a] -> a
last3 (a:b) | (length b) /= 0 = last3 b
            | otherwise       = a
```

`otherwise` equivale a `True` ed è usato come caso di default.

---

## 4. Ricorsione

In Haskell non esistono cicli `for` o `while`. Si usa la **ricorsione** per iterare.

```haskell
mfactorial :: Int -> Int
mfactorial n = foldr (*) 1 [1..n]

inverti :: [a] -> [a]
inverti [] = []
inverti (l:t) = inverti t ++ [l]

lengthh [] = 0
lengthh (a:b) = 1 + lengthh b
```

Il pattern tipico è: **caso base** (lista vuota o valore singolo) + **caso ricorsivo**.

---

## 5. Liste

Le liste sono il tipo di dati più usato in Haskell. Alcune operazioni fondamentali:

| Operazione | Funzione |
|---|---|
| Primo elemento | `head` |
| Resto della lista | `tail` |
| Lunghezza | `length` |
| Concatenazione | `++` |
| Inversione | `reverse` |
| Accesso per indice | `!!` |

```haskell
-- Diverse implementazioni di "ultimo elemento"
last1 a = head(reverse(a))
last2 a = a !! ((length a) - 1)
last4 [a]   = a
last4 (a:b) = last4 b
```

### Sintassi `(a:b)`

Il costrutto `(a:b)` **decostruisce** una lista: `a` è la testa (head) e `b` è il resto (tail).

```haskell
concatena :: [a] -> [a] -> [a]
concatena [] b    = b
concatena (a:b) c = a : concatena b c
```

---

## 6. Funzioni di Ordine Superiore

Haskell tratta le funzioni come valori: possono essere passate come argomenti o restituite.

### `map`
Applica una funzione a ogni elemento di una lista.

```haskell
quadList :: [Int] -> [Int]
quadList a = map (\x -> x * x) a

acronimo :: [String] -> [Char]
acronimo a = map (\x -> head x) a
```

### `filter`
Seleziona gli elementi che soddisfano un predicato.

```haskell
positivi :: [Int] -> [Int]
positivi a = filter (\x -> x > 0) a

vocali :: [Char] -> [Char]
vocali a = filter (\x -> inn x "aeiou") a
```

### `foldr` — riduzione da destra
Riduce una lista a un singolo valore applicando una funzione da destra. Struttura: `foldr f valore_iniziale lista`.

```haskell
-- Definizione manuale
foldrr f x []    = x
foldrr f x (a:b) = f a (foldrr f x b)

-- Esempi
sumf a = foldr (+) 0 a       -- somma
prod a = foldr (*) 1 a       -- prodotto

-- foldr (+) 0 [1,2,3] → 1+(2+(3+0)) = 6  (associatività a DESTRA)

-- Contare elementi
lengthFold a = foldr (\ x n -> n + 1) 0 a

-- Contare vocali
vocalii :: [Char] -> Int
vocalii a = foldr (\ x n -> if (elem x "aeiou") then n + 1 else n) 0 a
```

### `foldl` — riduzione da sinistra
Come `foldr` ma accumula da sinistra. Il valore accumulato viene aggiornato ad ogni passo.

```haskell
foldll f v []     = v
foldll f v (x:xs) = foldll f (f v x) xs

-- foldl (+) 0 [1,2,3] → ((0+1)+2)+3 = 6  (associatività a SINISTRA)
```

### Versioni point-free con `foldr`

```haskell
s :: [Int] -> Int
s = foldr (+) 0

p :: [Int] -> Int
p = foldr (*) 1

o :: [Bool] -> Bool
o = foldr (||) False

aa :: [Bool] -> Bool
aa = foldr (&&) True
```

---

## 7. Lambda (Funzioni Anonime)

Le **lambda** si scrivono con `\x -> espressione`. Sono utili con `map`, `filter`, `foldr`, ecc.

```haskell
map (\x -> x * x) [1,2,3]          -- [1,4,9]
filter (\x -> x > 0) [-1,2,-3,4]   -- [2,4]
```

---

## 8. Currying e Applicazione Parziale

In Haskell ogni funzione accetta **un solo argomento alla volta** e restituisce una nuova funzione per ogni argomento successivo. Questo si chiama **currying**.

```haskell
multiply :: Int -> Int -> Int
multiply x y = x * y

double2 = multiply 2   -- funzione parzialmente applicata
triple2 = multiply 3

-- Con le funzioni di lista
addOne       = map (+1)     -- aggiunge 1 a ogni elemento
greaterThan5 = filter (>5)  -- filtra valori > 5

-- Esempio con la gravità
gravity :: Float -> Float -> Float -> Float
gravity m1 d m2 = ((6.67 * 1/10^11) * (m1 * m2)) / (d * d)

earthGravity :: Float -> Float -> Float
earthGravity = gravity (5.972 * 10^24)   -- m1 fissata alla massa della Terra

earthGravitySurface = earthGravity 6371000  -- d fissata al raggio terrestre

-- Sections
log2 :: Float -> Float
log2 = logBase 2

rec :: Float -> Float
rec = (1/)
```

---

## 9. `zip` e Corrispondenze

`zip` unisce due liste in una lista di coppie. Utile per confrontare elementi in posizione corrispondente. Si ferma alla lista più corta.

```haskell
-- zip [1,2,3] ["a","b","c"] → [(1,"a"),(2,"b"),(3,"c")]

corrispondenze listaA listaB =
    filter (\(x, y) -> x == y) (zip listaA listaB)
```

---

## 10. Tuple

Le **tuple** raggruppano un numero fisso di valori, anche di tipi diversi.

```haskell
addVect :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVect a b = (fst a + fst b, snd a + snd b)
```

- `fst` restituisce il primo elemento di una coppia
- `snd` restituisce il secondo elemento

---

## 11. Tipi e Polimorfismo

Haskell è **fortemente tipizzato** ma supporta il **polimorfismo**: funzioni generiche che operano su qualsiasi tipo.

```haskell
-- [a] significa "lista di qualsiasi tipo"
last4 :: [a] -> a
inverti :: [a] -> [a]

-- (Num a) è un vincolo: a deve essere un tipo numerico
addVect :: (Num a) => (a, a) -> (a, a) -> (a, a)
```

---

## 12. Caratteri e Stringhe

In Haskell una `String` è semplicemente una lista di `Char` (`[Char]`).

```haskell
nsucc :: Char -> Int -> Char
nsucc c n = toEnum (fromEnum c + n)

-- Cifrario di Cesare
cypher :: [Char] -> Int -> [Char]
cypher a num = map (\x -> nsucc x num) a
```

- `fromEnum` converte un `Char` nel suo codice numerico (ASCII/Unicode)
- `toEnum` fa il contrario

---

## 13. Funzioni su Liste di Funzioni

In Haskell le funzioni sono valori di prima classe e possono essere messe in lista. Questo permette di applicare più controlli in sequenza in modo elegante.

```haskell
funandmap :: [(a -> Bool)] -> a -> Bool
funandmap [] b     = True
funandmap (a:at) b = a b && funandmap at b

-- Esempio: checker che combina più validatori
checker :: [Char] -> Bool
checker a = funandmap [check_cifre, check_lower, check_upper, check_lung] a
```

---

## 14. Esempio Completo — Validatore Password

Requisiti: lunghezza > 15, almeno una minuscola, almeno una maiuscola, almeno un numero.

```haskell
-- Versione modulare (4 checker separati)
checckers_1 :: [Char] -> Bool
checckers_1 a = (foldr (\ x n -> n + 1) 0 a) > 15

checckers_2 :: [Char] -> Bool
checckers_2 a = (foldr (\ x n -> if elem x ['A'..'Z'] then n+1 else n) 0 a) > 1

checckers_3 :: [Char] -> Bool
checckers_3 a = (foldr (\ x n -> if elem x ['a'..'z'] then n+1 else n) 0 a) > 1

checckers_4 :: [Char] -> Bool
checckers_4 a = (foldr (\ x n -> if elem x ['0'..'9'] then n+1 else n) 0 a) > 1

checker :: [Char] -> Bool
checker a = funandmap [checckers_4, checckers_3, checckers_2, checckers_1] a

-- Versione compatta (tutto in una funzione)
checker_litee :: [Char] -> Bool
checker_litee a =
    ((foldr (\ x n -> n + 1) 0 a) > 15) &&
    (foldr (\ x n -> elem x ['a'..'z'] || n) False a) &&
    (foldr (\ x n -> elem x ['A'..'Z'] || n) False a) &&
    (foldr (\ x n -> elem x ['0'..'9'] || n) False a)
```

---

## Riepilogo — Funzioni Utili

| Funzione | Descrizione |
|---|---|
| `head` / `tail` | Primo elemento / resto della lista |
| `reverse` | Inverte una lista |
| `length` | Lunghezza di una lista |
| `map f xs` | Applica `f` a ogni elemento |
| `filter p xs` | Mantiene gli elementi che soddisfano `p` |
| `foldr f z xs` | Riduzione da destra (`z` = valore iniziale) |
| `foldl f v xs` | Riduzione da sinistra (`v` = accumulatore) |
| `zip xs ys` | Unisce due liste in lista di coppie |
| `elem x xs` | `True` se `x` appartiene a `xs` |
| `fst` / `snd` | Primo / secondo elemento di una coppia |
| `fromEnum` / `toEnum` | Conversione `Char` ↔ `Int` |
| `logBase b x` | Logaritmo di `x` in base `b` |

---

```
Haskell è un linguaggio funzionale puro dove:
  - Tutto è una funzione
  - Non ci sono variabili mutabili
  - La ricorsione sostituisce i cicli
  - Il pattern matching rende il codice leggibile
  - Il currying permette l'applicazione parziale
  - I tipi garantiscono correttezza a compile-time
  - foldr/foldl riducono liste a valori con piena flessibilità
  - zip permette di lavorare su coppie di liste in parallelo
```