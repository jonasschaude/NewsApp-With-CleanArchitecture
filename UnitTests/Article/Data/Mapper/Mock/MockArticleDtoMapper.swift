@testable import NewsApp_With_CleanArchitecture

class MockArticleDtoMapper: ArticleDtoMapper {
    var mapCalledCounter = 0
    var receivedData: ArticlesDataModel?
    var articleEntities: [ArticleEntity] = []
    func map(_ data: ArticlesDataModel) -> [ArticleEntity] {
        mapCalledCounter += 1
        receivedData = data
        return articleEntities
    }
}
