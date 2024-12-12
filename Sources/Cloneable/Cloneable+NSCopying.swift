import Foundation

extension Cloneable where Self: NSCopying {
    /// Returns a new instance that is a deep copy of the original instance using `NSCopying`.
    /// 
    /// This method is a convenience method that uses `NSCopying` to create a deep copy of the original instance. This
    /// method works by calling `copy()` on the original instance. Because `NSCopying` is used, it is guaranteed to be a
    /// deep copy. But since `NSCopying` returns an `Any`, we must first typecast it to `Self`. Since this typecast can
    /// fail, this method returns an optional.
    func cloneUsingNSCopying() -> Self? {
        return self.copy() as? Self
    }
}

extension Cloneable where Self: NSMutableCopying {
    /// Returns a new instance that is a deep copy of the original instance using `NSMutableCopying`.
    /// 
    /// This method is a convenience method that uses `NSMutableCopying` to create a deep copy of the original instance.
    /// This method works by calling `mutableCopy()` on the original instance. Because `NSMutableCopying` is used, it is
    /// guaranteed to be a deep copy. But since `NSMutableCopying` returns an `Any`, we must first typecast it to `Self`.
    /// Since this typecast can fail, this method returns an optional.
    func cloneUsingNSMutableCopying() -> Self? {
        return self.mutableCopy() as? Self
    }
}