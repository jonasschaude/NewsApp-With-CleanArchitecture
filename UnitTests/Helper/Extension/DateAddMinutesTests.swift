import XCTest
@testable import NewsApp_With_CleanArchitecture

class DateAddMinutesTests: XCTestCase {
    func testAddMinutes__MinutesAreAddedToValue() {
        // Arrange
        let date = Date()

        // Act
        let result = date.addMinutes(value: 3)
        
        // Assert
        XCTAssertEqual(result, date.addingTimeInterval(TimeInterval(180)))
    }
}
