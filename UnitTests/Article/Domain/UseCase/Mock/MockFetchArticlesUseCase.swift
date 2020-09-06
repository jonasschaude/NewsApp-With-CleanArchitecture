@testable import NewsApp_With_CleanArchitecture

class MockFetchArticlesUseCase: FetchArticlesUseCase {
    var executeCalledCounter = 0
    var receivedCompletionHandler: FetchArticlesUseCaseCompletionHandler?
    func execute(_ completionHandler: @escaping FetchArticlesUseCaseCompletionHandler) {
        executeCalledCounter += 1
        receivedCompletionHandler = completionHandler
    }
}
