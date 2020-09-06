import Foundation

extension Date {
    func addMinutes(value: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(60*value))
    }
}
