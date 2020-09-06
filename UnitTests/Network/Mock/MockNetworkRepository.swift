import Foundation
@testable import NewsApp_With_CleanArchitecture

class MockNetworkRepository: NetworkRepository {
    var fetchRequestCalledCounter = 0
    var receivedURL: URL?
    var receivedCompletionHandler: FetchRequestResult?
    func fetchRequest(_ url: URL, result: @escaping FetchRequestResult) {
        fetchRequestCalledCounter += 1
        receivedURL = url
        receivedCompletionHandler = result
    }
}
