import Foundation
@testable import NewsApp_With_CleanArchitecture

class MockNewsApiFactory: NewsApiFactory {
    var createTopHeadlinesUrlCalledCounter = 0
    var urlComponents: URLComponents = URLComponents()
    func createTopHeadlinesUrl() -> URLComponents {
        createTopHeadlinesUrlCalledCounter += 1
        return urlComponents
    }
}
