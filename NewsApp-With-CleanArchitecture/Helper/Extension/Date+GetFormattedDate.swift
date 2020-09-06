import Foundation

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
