typealias FetchArticlesResult = (_ result: Result<[ArticleEntity], FetchArticlesError>) -> Void

protocol ArticleRepository {
    func fetchArticles(result: @escaping FetchArticlesResult)
}
