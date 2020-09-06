import Foundation

struct ArticleRepositoryImpl: ArticleRepository {
    let networkRepository: NetworkRepository
    let articleDtoMapper: ArticleDtoMapper
    let jsonDecoder: JSONDecoderProtocol
    let newsApiFactory: NewsApiFactory
    
    init(networkRepository: NetworkRepository = NetworkRepositoryImpl(), articleDtoMapper: ArticleDtoMapper = ArticleDtoMapperImpl(), jsonDecoder: JSONDecoderProtocol = JSONDecoder(), newsApiFactory: NewsApiFactory = NewsApiFactoryImpl()) {
        self.networkRepository = networkRepository
        self.articleDtoMapper = articleDtoMapper
        self.jsonDecoder = jsonDecoder
        self.newsApiFactory = newsApiFactory
    }
    
    func fetchArticles(result: @escaping FetchArticlesResult) {
        guard let url = newsApiFactory.createTopHeadlinesUrl().url else {
            result(.failure(.loading))
            return
        }
        networkRepository.fetchRequest(url) { networkResult in
            switch networkResult {
            case .success(let response):
                let (urlResponse, data) = response
                guard urlResponse.statusCode.isOk else {
                    result(.failure(.loading))
                    return
                }
                self.parse(data: data, result: result)
            case .failure:
                result(.failure(.loading))
            }
        }
    }
    
    private func parse(data: Data, result: @escaping FetchArticlesResult) {
        let decoderResult = jsonDecoder.decodeWithErrorHandling(ArticlesDataModel.self, from: data)
        switch decoderResult {
        case .success(let articles):
            let articlesPage = articleDtoMapper.map(articles)
            result(.success(articlesPage))
        case .failure:
            result(.failure(.parsing))
        }
    }
}
