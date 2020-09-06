@testable import NewsApp_With_CleanArchitecture

class ArticleListUiTileBuilder {
    
    private var article: ArticleEntity = ArticleEntityBuilder.new().build()
    
    static func new() -> ArticleListUiTileBuilder {
        return ArticleListUiTileBuilder()
    }
    
    func with(article: ArticleEntity) -> ArticleListUiTileBuilder {
        self.article = article
        return self
    }
    
    func build() -> ArticleListUiTile {
        ArticleListUiTile(article: article)
    }
}
