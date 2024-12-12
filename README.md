# Cloneable

This simple Swift library provides the `Cloneable` protocol, which allows you to easily create a deep copy of any object that conforms to it. This is useful when you 
want to copy the value of a reference type without sharing the same reference. Because they have different references, changes to the original object will not affect the
copied object and vice versa.

## Usage
To conform to the `Cloneable` protocol, simply implement the `init(cloning: Self)` initializer in your type. This initializer should perform a deep copy of the object. For more
information about the difference between a deep copy and a shallow copy, see [this article from Geeks for Geeks](https://www.geeksforgeeks.org/difference-between-shallow-and-deep-copy-of-a-class/).

### Cloning Versus Copying
For the sake of clarity let's define some terminology. In Swift we can copy values or references. When we copy a value, we are creating a new instance of the value. When we copy a reference, we are creating a new reference to the same instance. In the context of this library, whenever we use the term "clone" what we really mean is "deep copy". This means that we are copying the value of a reference type, not the reference itself. We are creating an entirely new instance of the object, not just a new reference to the same object.

### Cloning Reference Types
Suppose we have a reference type. If we make a copy of it, then we are sharing a reference between the original object and the copied object. This means that changes to the original object will affect the copied object and vice versa. 

```swift
class ReferenceType {
    var int: Int
    init(int: Int) {
        self.int = int
    }
}

var reference1 = ReferenceType(value: 1)
var reference2 = reference1
reference2.int = 2
print(reference1.int) // 2
print(reference2.int) // 2
```

To avoid this, we can conform to the `Cloneable` protocol and implement the `init(cloning: Self)` initializer.

```swift
extension ReferenceType: Cloneable {
    convenience init(cloning: ReferenceType) {
        self.init(int: cloning.int)
    }
}
var cloneOfReference1 = ReferenceType(cloning: reference1)
cloneOfReference1.int = 3
print(reference1.int) // 2
print(cloneOfReference1.int) // 3
```

By conforming to the `Cloneable` protocol, we also automatically get a convenience method called `clone()` that returns a deep copy of the object.

```swift
var cloneOfReference1 = reference1.clone()
```

### Cloning Value Types
In general, value types are copied by value, not by reference. This means that when we make a copy of a value type, we are already creating a new instance of the value. However, if the value type contains reference types, then each copy of the value type will share references to the same reference types. To avoid this, we can conform to the `Cloneable` protocol and implement the `init(cloning: Self)` initializer.

```swift
struct ValueType {
    var referenceType: ReferenceType
}
extension ValueType: Cloneable {
    init(cloning original: ValueType) {
        self.referenceType = original.referenceType.clone()
    }
}
```

### Cloning Using Codable
If your type conforms to `Codable`, then the `Cloneable` protocol will automatically generate a method called 
`cloneUsingCodable()` that returns a deep copy of the object using `JSONEncoder` and `JSONDecoder`. This method is useful when you don't want to maintain your own implementation of the `Cloneable` protocol, and just want `Codable`  to "handle it for you". Whereas `init(cloning: )` relies on you to ensure that your copy is a recursive deep copy, `cloneUsingCodable()` is guaranteed to be a deep copy. The catch is that encoding and decoding can fail. Therefore, the method returns an optional.

```swift
guard let cloneOfReference1 = reference1.cloneUsingCodable() else {
    // Handle error
}
```

### Cloning Using NSCopying and NSMutableCopying
If your type conforms to `NSCopying` or `NSMutableCopying`, then the `Cloneable` protocol will automatically generate a method called `cloneUsingNSCopying()` or `cloneUsingNSMutableCopying()` respectively. These methods return a deep copy of the object using the `copy()` or `mutableCopy()` methods of `NSCopying` and `NSMutableCopying`. These methods are not much different than vanilla `NSCopying` and `NSMutableCopying`, but they add a layer of convenience by handling the type casting for you. The catch is that the methods return an optional.

```swift
guard let cloneOfReference1 = reference1.cloneUsingNSCopying() else {
    // Handle error
}
```

## Installation
### Swift Package Manager
To install Cloneable using the Swift Package Manager, add the following line to your `Package.swift` file in the dependencies array:

```swift
dependencies: [
    .package(url: "", from: "1.0.0")
]
```

Then add the following line to your target's dependencies array:

```swift
dependencies: [
    .product(name: "Cloneable", package: "Cloneable")
]
```

## License
This library is licensed under the MIT license. See `LICENSE` for more information.
