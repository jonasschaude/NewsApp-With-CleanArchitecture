import XCTest
@testable import NewsApp_With_CleanArchitecture

class ArticleListViewModelTests: XCTestCase {
    var sut: ArticleListViewModel!
    var mockFetchArticlesUseCase: MockFetchArticlesUseCase!
    var mockArticleListUiTileMapper: MockArticleListUiTileMapper!
    
    override func setUp() {
        DispatchContainerImpl.shared = StubDispatcher()
        mockFetchArticlesUseCase = MockFetchArticlesUseCase()
        mockArticleListUiTileMapper = MockArticleListUiTileMapper()
        sut = ArticleListViewModel(fetchArticlesUseCase: mockFetchArticlesUseCase, articleListUiTileMapper: mockArticleListUiTileMapper)
    }
    
    func testRefreshArticles__IsLoadingIsSetToTrue() {
        // Arrange
        sut.isEmpty = true
        
        // Act
        sut.refreshArticles()
        
        // Assert
        XCTAssertEqual(sut.isLoading, true)
    }
    
    func testRefreshArticles__TitleIsSetToEmptyString() {
        // Arrange
        sut.isEmpty = true
        
        // Act
        sut.refreshArticles()
        
        // Assert
        XCTAssertEqual(sut.title, "")
    }
    
    func testInit__FetchArticlesUseCaseIsCalledOnce() {
        // Assert
        XCTAssertEqual(mockFetchArticlesUseCase.executeCalledCounter, 1)
    }
    
    func testRefreshArticles__FetchArticlesUseCaseIsCalledOnce() {
        // Arrange
        mockFetchArticlesUseCase.executeCalledCounter = 0
        
        // Act
        sut.refreshArticles()
        
        // Assert
        XCTAssertEqual(mockFetchArticlesUseCase.executeCalledCounter, 1)
    }
    
    func testRefreshArticles__ArticleListUiTileMapperIsCalledOnce() {
        // Arrange
        let articles = [
            ArticleEntityBuilder.new().build()
        ]
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?(articles)
        
        // Assert
        XCTAssertEqual(mockArticleListUiTileMapper.mapCalledCounter, 1)
        XCTAssertEqual(mockArticleListUiTileMapper.receivedArticles, articles)
    }
    
    func testRefreshArticles_ArticleListUiTileMapperReturnsNoUiArticles_IsEmptyIsSetToTrue() {
        // Arrange
        let articles = [
            ArticleEntityBuilder.new().build()
        ]
        mockArticleListUiTileMapper.articleListUiTiles = []
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?(articles)
        
        // Assert
        XCTAssertEqual(sut.isEmpty, true)
    }
    
    func testRefreshArticles_ArticleListUiTileMapperReturnsMultipleUiArticles_IsEmptyIsSetToFalse() {
        // Arrange
        let articles = [
            ArticleEntityBuilder.new().build()
        ]
        mockArticleListUiTileMapper.articleListUiTiles = [
            ArticleListUiTileBuilder.new().build()
        ]
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?(articles)
        
        // Assert
        XCTAssertEqual(sut.isEmpty, false)
    }
    
    func testRefreshArticles_ArticleListUiTileMapperReturnsMultipleUiArticles_ArticlesAreSet() {
        // Arrange
        let articles = [
            ArticleListUiTileBuilder.new().build()
        ]
        mockArticleListUiTileMapper.articleListUiTiles = articles
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?([
            ArticleEntityBuilder.new().build()
        ])
        
        // Assert
        XCTAssertEqual(sut.articles, articles)
    }
    
    func testRefreshArticles_ArticleListUiTileMapperReturnsMultipleUiArticles_IsLoadingIsSetToFalse() {
        // Arrange
        let articles = [
            ArticleListUiTileBuilder.new().build()
        ]
        mockArticleListUiTileMapper.articleListUiTiles = articles
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?([
            ArticleEntityBuilder.new().build()
        ])
        
        // Assert
        XCTAssertEqual(sut.isLoading, false)
    }
    
    func testRefreshArticles_ArticleListUiTileMapperReturnsMultipleUiArticles_TitleIsUpdated() {
        // Arrange
        let articles = [
            ArticleListUiTileBuilder.new().build()
        ]
        mockArticleListUiTileMapper.articleListUiTiles = articles
        
        // Act
        sut.refreshArticles()
        mockFetchArticlesUseCase.receivedCompletionHandler?([
            ArticleEntityBuilder.new().build()
        ])
        
        // Assert
        XCTAssertEqual(sut.title, "Latest News, \(Date().getFormattedDate(format: "MMM d"))")
    }
}
