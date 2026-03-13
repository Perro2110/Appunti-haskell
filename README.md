# 📘 Haskell — Appunti e Concetti Fondamentali

Questo documento raccoglie i concetti appresi finora in Haskell, con esempi tratti dal codice scritto durante le esercitazioni.

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

### `foldr`
Riduce una lista a un singolo valore applicando una funzione da destra.

```haskell
mfactorial :: Int -> Int
mfactorial n = foldr (*) 1 [1..n]
```

---

## 7. Lambda (Funzioni Anonime)

Le **lambda** si scrivono con `\x -> espressione`. Sono utili con `map`, `filter`, ecc.

```haskell
map (\x -> x * x) [1,2,3]   -- [1,4,9]
filter (\x -> x > 0) [-1,2,-3,4]  -- [2,4]
```

---

## 8. Currying

In Haskell ogni funzione accetta **un solo argomento alla volta** e restituisce una nuova funzione per ogni argomento successivo. Questo si chiama **currying**.

```haskell
multiply :: Int -> Int -> Int
multiply x y = x * y

double2 = multiply 2   -- funzione parzialmente applicata
triple2 = multiply 3
```

Si possono creare facilmente funzioni specializzate per **applicazione parziale**:

```haskell
addOne     = map (+1)        -- aggiunge 1 a ogni elemento
greaterThan5 = filter (>5)   -- filtra valori > 5

-- Esempio con la gravità
gravity :: Float -> Float -> Float -> Float
gravity m1 d m2 = ((6.67 * 1/10^11) * (m1 * m2)) / (d * d)

earthGravity :: Float -> Float -> Float
earthGravity = gravity (5.972 * 10^24)   -- m1 fissata alla massa della Terra

earthGravitySurface = earthGravity 6371000  -- d fissata al raggio terrestre
```

---

## 9. Tuple

Le **tuple** raggruppano un numero fisso di valori, anche di tipi diversi.

```haskell
addVect :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVect a b = (fst a + fst b, snd a + snd b)
```

- `fst` restituisce il primo elemento di una coppia
- `snd` restituisce il secondo elemento

---

## 10. Tipi e Polimorfismo

Haskell è **fortemente tipizzato** ma supporta il **polimorfismo**: funzioni generiche che operano su qualsiasi tipo.

```haskell
-- [a] significa "lista di qualsiasi tipo"
last4 :: [a] -> a
inverti :: [a] -> [a]

-- (Num a) è un vincolo: a deve essere un tipo numerico
addVect :: (Num a) => (a, a) -> (a, a) -> (a, a)
```

---

## 11. Caratteri e Stringhe

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

## 12. Funzioni Utili Ricorrenti

| Funzione | Descrizione |
|---|---|
| `head` | Primo elemento di una lista |
| `tail` | Lista senza il primo elemento |
| `reverse` | Inverte una lista |
| `length` | Lunghezza di una lista |
| `map f xs` | Applica `f` a ogni elemento |
| `filter p xs` | Mantiene gli elementi che soddisfano `p` |
| `foldr f z xs` | Riduzione da destra |
| `fst`, `snd` | Elementi di una coppia |
| `fromEnum`, `toEnum` | Conversione Char ↔ Int |
| `logBase` | Logaritmo in base arbitraria |

---

## Riepilogo

```
Haskell è un linguaggio funzionale puro dove:
  ✔ Tutto è una funzione
  ✔ Non ci sono variabili mutabili
  ✔ La ricorsione sostituisce i cicli
  ✔ Il pattern matching rende il codice leggibile
  ✔ Il currying permette l'applicazione parziale
  ✔ I tipi garantiscono correttezza a compile-time
```