# Analysis of Algorithms

## Observations

## Mathematical Models
some java code
```java
int count = 0
for (int i = 0; i < N; i++) {
    if (a[i] == 0) {
        count += 1
    }   
}
return count
```
```java
int count = 0
for (int i = 0; i < N; i++) {
    for (int j = i + 1; j < n; j++) {
        if (a[i] + a[j] == 0) {
            count += 1
        }
    }
}
```

|operation|frequency|tilda|
|---------|---------|---|
|variable declaration| N + 2 | ~N |
| assignment statement | N + 2 | ~N |
| less than compare | 1/2 (N+1)(N+2) | ~N^2|
| equal to compare | 1/2 N (N-1) | ~N^2|
| array access | **N(N-1)** | ~N^2 | 
| increment | 1/2 N(N-1) to N(N-1) | ~N^2|

Simplification
- tilde notation

?? things may changed with compiler optimization involved.

## order-of-growth classifications
 

## theory of algorithms
|𝚯 | O| 𝛀| 
|---|---|---|
| Goal | Upper bound | Lower bound |

## memory
