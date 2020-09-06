import Foundation

class FetchArticlesUseCaseImpl: FetchArticlesUseCase {
    let articleRepository: ArticleRepository
    var lastFetchedAt: Date? = nil
    var lastFetchedArticles: [ArticleEntity]? = nil
    
    init(articleRepository: ArticleRepository = ArticleRepositoryImpl()) {
        self.articleRepository = articleRepository
    }
    
    func execute(_ completionHandler: @escaping FetchArticlesUseCaseCompletionHandler) {
        guard shouldUpdate() else {
            return
        }
        articleRepository.fetchArticles { [weak self] fetchArticlesResult in
            switch fetchArticlesResult {
            case .success(let articles):
                self?.lastFetchedAt = Date()
                self?.lastFetchedArticles = articles
                completionHandler(articles)
            case .failure:
                break
            }
        }
    }
    
    private func shouldUpdate() -> Bool {
        guard let lastFetchedAt = lastFetchedAt else {
            return true
        }
        return lastFetchedAt.addMinutes(value: 5) <= Date()
    }
}
