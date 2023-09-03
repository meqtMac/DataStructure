# StacksAndQueues


## Stack

```swift
protocol StackProtocol<Element> {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    var isEmpty: Bool { get }
    var count: Int { get }
}

```

### linked-list implementation

## Resizing-array
### amortized cost of adding to a stack
```swift
var arr: [Int] = []
for i in (1...10000) {
    arr.append(i)
    print("|\(arr.count)|\(arr.capacity)|")
}
```
🧐
|count|capacity|
|-----|--------|
|64|64|
|65|188|
|188|188|
|189|380|
|380|380|
|381|764|
|764|764|
|765|1532|
|1532|1532|
|1533|3068|
|3068|3068|
|3069|8188|
|8188|8188|
|8189|16380|



```swift
for _ in (1...10000) {
    arr.removeLast()
    print("|\(arr.count)|\(arr.capacity)|")
}
```
🧐
|count|capacity|
|-----|--------|
|2|16380|
|1|16380|
|0|16380|

### Queues

### Java Generics

### Java Iterators

### Swift Iterators

- `Sequence`, 
- `Iterator`
- `makeIterator`

### Applications

#### Dijkstra's two-stack algorithms
- Value: push onto the value stack
- Operator: push onto the operator stack
- Left parenthesis: ignore
- Right parenthesis: pop operator and two values; push the result of applying that operator to those values onto the operand stack.
