# List
A generic Swift wrapper around a linked list written in C. It includes some additional wrappers for other list-like structures.

## Usage

```swift
import List

let list = List<Int>()
let stack = Stack<Int>()
let queue = Queue<Int>()

list.append(5)
_ = stack.pop()
queue.enqueue(5)

for element in list {
    print(element)
}
```
