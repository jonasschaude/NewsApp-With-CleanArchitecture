@testable import NewsApp_With_CleanArchitecture

class MockArticleRepository: ArticleRepository {
    var fetchArticlesCalledCounter = 0
    var fetchArticlesCompletionHandler: FetchArticlesResult?
    func fetchArticles(result: @escaping FetchArticlesResult) {
        fetchArticlesCalledCounter += 1
        fetchArticlesCompletionHandler = result
    }
}
