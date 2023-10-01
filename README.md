# TopologicalSort

## Example

Here is a simple example to use the topological sort.

```Swift
/// Like Makefile
/// main: objA objB
/// objA: objA.c objA.h
/// objB: objB.c objB.h
 
var top = TopologicalSort<String>()
top.add(predecessor: "objB.h", successor: "objB")
top.add(predecessor: "objB.c", successor: "objB")
top.add(predecessor: "objA.h", successor: "objA")
top.add(predecessor: "objA.c", successor: "objA")
top.add(predecessor: "objA", successor: "main")
top.add(predecessor: "objB", successor: "main")

top.popAll() // The result may be ["objA.c", "objA.h", "objB.c", "objB.h"].
top.popAll() // The result may be ["objA", "objB"].
top.popAll() // The result must be ["main"].
```
