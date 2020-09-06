typealias FetchArticlesUseCaseCompletionHandler = (_ articles: [ArticleEntity]) -> Void

protocol FetchArticlesUseCase {
    func execute(_ completionHandler: @escaping FetchArticlesUseCaseCompletionHandler)
}
