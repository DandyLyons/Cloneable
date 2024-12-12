import Foundation

extension Cloneable where Self: Codable {
    /// Returns a new instance that is a deep copy of the original instance using `Codable`.
    /// 
    /// This method is a convenience method that uses `JSONEncoder` and `JSONDecoder` to create a deep copy of the original
    /// instance. This method works by encoding the original instance to JSON data and then decoding it back to a new
    /// instance. Because we are encoding and decoding the instance, it is guaranteed to be a deep copy. But since the 
    /// encoding and decoding process can fail, this method returns an optional.
    func cloneUsingCodable() -> Self? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}