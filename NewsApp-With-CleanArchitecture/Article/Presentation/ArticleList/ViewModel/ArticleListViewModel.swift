import Combine
import Foundation

class ArticleListViewModel: ObservableObject {
    
    private let fetchArticlesUseCase: FetchArticlesUseCase
    private let articleListUiTileMapper: ArticleListUiTileMapper
    
    @Published var title: String = ""
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var articles: [ArticleListUiTile] = []
    
    init(fetchArticlesUseCase: FetchArticlesUseCase = FetchArticlesUseCaseImpl(), articleListUiTileMapper: ArticleListUiTileMapper = ArticleListUiTileMapperImpl()) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
        self.articleListUiTileMapper = articleListUiTileMapper
        refreshArticles()
    }
    
    func refreshArticles() {
        self.title = ""
        self.isLoading = true
        fetchArticlesUseCase.execute { [weak self] result in
            onMainThreadAsync { [weak self] in
                guard let articles = self?.articleListUiTileMapper.map(result) else {
                    return
                }
                self?.isEmpty = articles.count == 0
                self?.articles = articles
                self?.isLoading = false
                self?.title = "Latest News, \(Date().getFormattedDate(format: "MMM d"))"
            }
        }
    }
}
