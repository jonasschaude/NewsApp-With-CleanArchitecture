import Foundation
@testable import NewsApp_With_CleanArchitecture

class MockURLSession: URLSessionProtocol {
    var dataTaskCalledCounter = 0
    var receivedDataTaskURL: URL?
    var receivedDataTaskCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var receivedDataTaskReturnURLSessionDataTask: URLSessionDataTask = MockURLSessionDataTask()
    var dataTaskReturnURLSessionDataTask: URLSessionDataTask = MockURLSessionDataTask()
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCalledCounter += 1
        receivedDataTaskURL = url
        receivedDataTaskCompletionHandler = completionHandler
        return dataTaskReturnURLSessionDataTask
    }
}
