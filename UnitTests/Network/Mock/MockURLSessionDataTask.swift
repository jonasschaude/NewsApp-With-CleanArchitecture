import Foundation
@testable import NewsApp_With_CleanArchitecture

class MockURLSessionDataTask: URLSessionDataTask {
    var resumeCalledCounter = 0
    
    override init() {
    }

    override func resume() {
        resumeCalledCounter += 1
    }
}
