import XCTest
@testable import NewsApp_With_CleanArchitecture

class ArticleDetailViewModelTests: XCTestCase {
    var sut: ArticleDetailViewModel!
    var articleListUiTile: ArticleListUiTile!
    var mockURLSession: MockURLSession!
    var mockUIApplicationContainer: MockUIApplicationContainer!
    
    override func setUp() {
        DispatchContainerImpl.shared = StubDispatcher()
        mockUIApplicationContainer = MockUIApplicationContainer()
        articleListUiTile = ArticleListUiTileBuilder.new().build()
        mockURLSession = MockURLSession()
        sut = ArticleDetailViewModel(article: articleListUiTile, urlSession: mockURLSession, uiApplicationContainer: mockUIApplicationContainer)
    }
    
    func testIsImageAvailable__IsSetToFalse() {
        // Act
        let result = sut.isImageAvailable
        
        // Assert
        XCTAssertEqual(result, false)
    }
    
    func testOpenArticle__CallsOpenWithArticleUrl() {
        // Arrange
        let url = URL(string: "http://example2.com")!
        let article = ArticleEntityBuilder.new().with(url: url).build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        sut.openArticle()
        
        // Assert
        XCTAssertEqual(mockUIApplicationContainer.openCalledCounter, 1)
        XCTAssertEqual(mockUIApplicationContainer.receivedURL, url)
    }
    
    func testContent__ReturnsArticleContent() {
        // Arrange
        let article = ArticleEntityBuilder.new().with(content: "Saul goodman").build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.content

        // Assert
        XCTAssertEqual(result, "Saul goodman")
    }
    
    func testHeadline__ReturnsArticleTitle() {
        // Arrange
        let article = ArticleEntityBuilder.new().with(title: "Test123").build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.headline

        // Assert
        XCTAssertEqual(result, "Test123")
    }
    
    func testSubheadline__ReturnsArticleTitle() {
        // Arrange
        let article = ArticleEntityBuilder.new().with(description: "Ai caramba").build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.subheadline

        // Assert
        XCTAssertEqual(result, "Ai caramba")
    }
    
    func testPublished__ReturnsPublishedAtWithAuthor() {
        // Arrange
        let date = Date()
        let article = ArticleEntityBuilder.new().with(publishedAt: date).with(author: "Spencer").build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.published

        // Assert
        XCTAssertEqual(result, "\(date.getFormattedDate(format: "HH:mm E, d MMM y")) by Spencer")
    }
    
    func testTitle__ReturnsArticleTitle() {
        // Arrange
        let article = ArticleEntityBuilder.new().with(title: "Al gimnasio").build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.title

        // Assert
        XCTAssertEqual(result, "Al gimnasio")
    }
    
    func testImageData_WithValidData_UpdatesIsImageAvailableProperty() {
        // Arrange
        sut.isImageAvailable = false
        let data = "asdf".data(using: .utf8)

        // Act
        sut.imageData = data

        // Assert
        XCTAssertEqual(sut.isImageAvailable, true)
    }
    
    func testImageData_WithoutData_UpdatesIsImageAvailableProperty() {
        // Arrange
        sut.isImageAvailable = true

        // Act
        sut.imageData = nil

        // Assert
        XCTAssertEqual(sut.isImageAvailable, false)
    }
    
    func testUrl__ReturnsArticleUrl() {
        // Arrange
        let url = URL(string: "http://example.com")!
        let article = ArticleEntityBuilder.new().with(url: url).build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        let result = sut.url

        // Assert
        XCTAssertEqual(result, url)
    }
    
    func testOnAppear__CallsUrlSessionWithImageUrl() {
        // Arrange
        let imageUrl = URL(string: "http://imageUrlExample.com")!
        let article = ArticleEntityBuilder.new().with(imageUrl: imageUrl).build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        sut.onAppear()

        // Assert
        XCTAssertEqual(mockURLSession.dataTaskCalledCounter, 1)
        XCTAssertEqual(mockURLSession.receivedURL, imageUrl)
    }
    
    func testOnAppear_WithRetrievedData_UpdatesImageData() {
        // Arrange
        let imageUrl = URL(string: "http://imageUrlExample.com")!
        let article = ArticleEntityBuilder.new().with(imageUrl: imageUrl).build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        let data = "as".data(using: .utf8)
        
        // Act
        sut.onAppear()
        mockURLSession.receivedCompletionHandler?(data, nil, nil)

        // Assert
        XCTAssertEqual(sut.imageData, data)
    }
    
    func testOnAppear__DataTaskResumeCalledOnce() {
        // Arrange
        let imageUrl = URL(string: "http://imageUrlExample.com")!
        let article = ArticleEntityBuilder.new().with(imageUrl: imageUrl).build()
        sut.article = ArticleListUiTileBuilder.new().with(article: article).build()
        
        // Act
        sut.onAppear()

        // Assert
        XCTAssertEqual(mockURLSession.mockURLSessionDataTask.resumeCalledCounter, 1)
    }
}
