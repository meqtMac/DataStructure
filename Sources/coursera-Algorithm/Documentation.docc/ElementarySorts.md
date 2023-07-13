# ElementarySorts

## Sorting Introduction
### Callbacks

Implementing callbacks
|Programming Language| Implementation|
|--------------------|---------------|
| Java | Interfaces | 
| C | function pointer |
| C++ | class-type functors | 
| C# | delegates | 
| Python, Perl, ML, JavaScript |  first-class functions |
| Swift | Protocol? |

```java
// java
public interface Comparable<Item> {
    public int compareTo(Item that);
}
```

```swift 
// swift
protocol Comparable {
    static func <(_ lhs: Self, _ rhs: Self) -> Bool
}

struct SomeStruct<Element> where Element: Comparable {
    
}
```

### Total order
- Antisymmetry: if `v<=w` and `w<=v` then `v=w`
- Transitivity: if `v<=w` and `w<=x` then `v<=x`
- Totality: either `v<=w` or `w<=v` or both

one that's not total: rock, paper, sisscor

### Two useful sorting abstractions
- Less
- Swap

### Testing
- isSorted

If the sorting algorithm passes the test, did it correctly sort the array?

## Selection Sort

## Insertion sort demo.

### partially-sorted arrays.
Can be linear time.

## Shell Sort

*h*-sorting array.
increments 7, 3, 1

### intuition

Proposition: A *g*-sorted array remains *g*-sorted after *h*-sorting it.

increment sequence.
- Powers of two. ❌
- 3x+1 😀

#### it seems that it can be done in multi thread 🤔

### analysis

Proposition: The worst-case number of compares used by shellsort with 3x+1 increment is `O(N^{3/2})`

Property: 

Useful in practice:
- Fast unless array size is huge.
- Tiny, fixed footprint for code (used in embedded systems).
- Hardware sort prototype.

Simple algorithm, nontrivial performance, interesting questions.
- Asymptotic growth rate?
- Best sequence of increments?
- Average-case performance?

## Shuffling

### Shuffle sort
- random real number for each array entry
- sort with the assigned number.

### Knuth shuffle
- In Iteration i, pick integer r between 0 and i uniformly at random
**0 to i** or **i to (N-1)** both works, but not **0 to (N-1)** 🧐
- swap a[i] and a[r].
[Fisher-Yates]
- The generation of  random numbers is too important to be left to chance.

Take online poker game for example
- 2^32 vs. 56!
- seed
- see some cards and synchronize server time.

## Convex Hull.

**equivalence**: 
- Smallest convex set containing all the points.
- Smallest area convex polygon enclosing the points.
- Convex polygon enclosing the points, whose vertices are points in set.

applications: farthest pair
- mechanical algorithm
- obstacle
- Farthest pair problem.


### geometric properties
- Fact: Can traverse the convex hull by making only counterclockwise turns
- Fact: The vertices of convex hull appear in increasing order of polar angle with respect to point p with lowest *y*-coordinate.

### Graham scan demo
- Choose point *p* with smallest *y*-coordinate
- Sort points by polar angle with *p*.
- Consider points in order; discard unless it creat a **ccw turn**.

how to define a **ccw turn**?

|Questions|Answer| 
|---------|------|
|find point p with smallest *y*-coordinates|define total order, comparing by y-coordinate|
|sorts points by polar angle with respect to *p*|define a total order for each point p|
|**counter clock wise** turn |Computational geometry, or if on one line|
|How to sort efficiently|Mergesort sorts in NlogN times.|





