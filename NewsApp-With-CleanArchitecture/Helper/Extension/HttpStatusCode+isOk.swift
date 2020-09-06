typealias HTTPStatusCode = Int

extension HTTPStatusCode {
    var isOk: Bool {
        return self >= 200 && self < 300
    }
}
