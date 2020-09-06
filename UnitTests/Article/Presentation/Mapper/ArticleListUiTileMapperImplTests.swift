import XCTest
@testable import NewsApp_With_CleanArchitecture

class ArticleListUiTileMapperImplTests: XCTestCase {
    var sut: ArticleListUiTileMapperImpl!
    
    override func setUp() {
        sut = ArticleListUiTileMapperImpl()
    }
    
    func testMap__ReturnsArticleListUiTiles() {
        // Arrange
        let article = ArticleEntityBuilder.new().build()
        let articleListUiTile = ArticleListUiTileBuilder.new().with(article: article).build()

        // Act
        let result = sut.map([article])

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, articleListUiTile)
    }
}
