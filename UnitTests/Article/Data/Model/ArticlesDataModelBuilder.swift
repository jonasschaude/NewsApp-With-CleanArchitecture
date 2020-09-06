@testable import NewsApp_With_CleanArchitecture

class ArticlesDataModelBuilder {
    private var articles: [ArticleItemDataModel] = []
    
    static func new() -> ArticlesDataModelBuilder {
        return ArticlesDataModelBuilder()
    }
    
    func with(articles: [ArticleItemDataModel]) -> ArticlesDataModelBuilder {
        self.articles = articles
        return self
    }
    
    func build() -> ArticlesDataModel {
        return ArticlesDataModel(articles: articles)
    }
}
