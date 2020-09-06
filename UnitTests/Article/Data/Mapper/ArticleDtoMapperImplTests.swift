import XCTest
@testable import NewsApp_With_CleanArchitecture

class ArticleDtoMapperImplTests: XCTestCase {
    var sut: ArticleDtoMapperImpl!
    
    override func setUp() {
        sut = ArticleDtoMapperImpl()
    }
    
    func testMap__ReturnsMappedArticleEntity() {
        // Arrange
        let date = "2020-09-05T13:58:18Z".toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        let articleItemDataModel = ArticleItemDataModelBuilder.new().with(url: "http://www.example.com").with(title: "title").with(author: "author").with(content: "content").with(urlToImage: "http://www.exampleimage.com").with(description: "description").with(publishedAt: "2020-09-05T13:58:18Z").build()
        let articlesDataModel = ArticlesDataModelBuilder.new().with(articles: [articleItemDataModel]).build()
        let expectedArticleEntity = ArticleEntityBuilder.new().with(title: "title").with(description: "description").with(content: "content").with(author: "author").with(publishedAt: date!).with(url: URL(string: "http://www.example.com")!).with(imageUrl: URL(string: "http://www.exampleimage.com")!).build()

        // Act
        let result = sut.map(articlesDataModel)

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, expectedArticleEntity)
    }
}
