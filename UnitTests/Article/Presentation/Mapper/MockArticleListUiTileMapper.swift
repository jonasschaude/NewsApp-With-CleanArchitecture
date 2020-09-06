@testable import NewsApp_With_CleanArchitecture

class MockArticleListUiTileMapper: ArticleListUiTileMapper {
    var mapCalledCounter = 0
    var receivedArticles: [ArticleEntity]?
    var articleListUiTiles: [ArticleListUiTile] = []
    func map(_ articles: [ArticleEntity]) -> [ArticleListUiTile] {
        mapCalledCounter += 1
        receivedArticles = articles
        return articleListUiTiles
    }
}
