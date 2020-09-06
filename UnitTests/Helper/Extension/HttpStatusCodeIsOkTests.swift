import XCTest
@testable import NewsApp_With_CleanArchitecture

class HttpStatusCodeIsOkTests: XCTestCase {
    func testIsOk_WithStatusCode200_ReturnsTrue() {
        // Arrange
        let statusCode = 200

        // Act
        let result = statusCode.isOk
        
        // Assert
        XCTAssertEqual(result, true)
    }

    func testIsOk_WithStatusCode199_ReturnsFalse() {
        // Arrange
        let statusCode = 199

        // Act
        let result = statusCode.isOk
        
        // Assert
        XCTAssertEqual(result, false)
    }
    
    func testIsOk_WithStatusCode299_ReturnsTrue() {
        // Arrange
        let statusCode = 299

        // Act
        let result = statusCode.isOk
        
        // Assert
        XCTAssertEqual(result, true)
    }

    func testIsOk_WithStatusCode300_ReturnsFalse() {
        // Arrange
        let statusCode = 300

        // Act
        let result = statusCode.isOk
        
        // Assert
        XCTAssertEqual(result, false)
    }
}
