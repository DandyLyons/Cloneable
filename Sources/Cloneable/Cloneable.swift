
/// A type that can clone itself, creating a deep copy of the original instance.
/// 
/// To make a type cloneable, conform to `Cloneable` and implement the `init(cloning:)` initializer.
/// A "clone" is a deep copy of the original instance. For more info on deep copies, see [Difference between Shallow and Deep copy of a class - GeeksforGeeks](https://www.geeksforgeeks.org/difference-between-shallow-and-deep-copy-of-a-class/).
/// 
/// The `init(cloning:)` initializer should create a new instance
/// with the same values as the original instance. If the type contains reference types, you must ensure that they are
/// copied as well. The `clone()` method is provided as a convenience method to create a clone of the instance.
/// 
/// IMPORTANT: By conforming to `Cloneable`, you are promising that the `init(cloning:)` initializer will create a deep
/// copy of the original instance. If the type contains reference types, you must ensure that they are copied as well.
/// This means that all properties should recursively be copies so that no reference is shared between the original
/// instance and the clone. 
/// 
/// For best results it is recommended that `Cloneable` should be implemented "from the ground up". This means that all
/// types that are used as properties should also conform to `Cloneable`. This way, when you implement `Clonable` for a
/// type, you can simply call `clone()` on all properties that are `Cloneable` to create a deep copy.
protocol Cloneable {
    /// Returns a new instance that is a deep copy of the original instance.
    init(cloning original: Self)
    /// A convenience method to create a deep copy of the instance.
    func clone() -> Self
}
extension Cloneable {
    func clone() -> Self {
        return Self(cloning: self)
    }
}
