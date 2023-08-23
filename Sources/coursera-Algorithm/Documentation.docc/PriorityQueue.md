# PriorityQueue

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

## Binary Heap

### Complete tree

Perfectly Balanced, except for bottom level.

#### Heap-ordered binary tree.
- Parent's key no smaller than children's Keys

#### Array representation
- Indices start at **1**
- Take nodes in level order
- **No explicit links needed**!

#### Binary heap properites

Proposition: Largest key is a[1], which is root of binary tree.

Proposition: Can use array indices to move through tree.

#### Promotion is a heap

#### Immutability: properities


### Event-Driven Simulation

#### Time-driven simulation
Main drawbacks
- $N^2 / 2$ overlap checks per time quantum.
- Simulationis too slow if *dt* is very small.

#### Event-driven simulation
- Between collisions, particles move in straight-lien trajectories
- Focus only on times when collisions occur.
- Maintian PQ of collisions events, prioritized by time.
- Remove the min == get next collision.

- Collision prediction.
- Collision resolution.



