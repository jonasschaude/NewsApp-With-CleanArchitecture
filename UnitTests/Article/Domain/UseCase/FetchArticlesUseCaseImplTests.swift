import XCTest
@testable import NewsApp_With_CleanArchitecture

class FetchArticlesUseCaseImplTests: XCTestCase {
    private var sut: FetchArticlesUseCaseImpl!
    private var mockArticleRepository: MockArticleRepository!
    
    override func setUp() {
        mockArticleRepository = MockArticleRepository()
        sut = FetchArticlesUseCaseImpl(articleRepository: mockArticleRepository)
    }
    
    func test_Execute_WhenNoRequestPerformedWithinLast5Minutes_ThenFetchArticlesIsCalledOnce() {
        // Act
        sut.execute { articles in
        }

        // Assert
        XCTAssertEqual(mockArticleRepository.fetchArticlesCalledCounter, 1)
    }
    
    func test_Execute_WhenRequestPerformedSuccessfullyWithinLast5Minutes_ThenFetchArticlesIsNotCalled() {
        // Arrange
        sut.execute { articles in
        }
        mockArticleRepository.fetchArticlesCompletionHandler?(.success([]))
        mockArticleRepository.fetchArticlesCalledCounter = 0

        // Act
        sut.execute { articles in
        }

        // Assert
        XCTAssertEqual(mockArticleRepository.fetchArticlesCalledCounter, 0)
    }
    
    func test_Execute_WhenRequestPerformedUnsuccessfullyWithLoadingErrorWithinLast5Minutes_ThenFetchArticlesIsCalledAgain() {
        // Arrange
        sut.execute { articles in
        }
        mockArticleRepository.fetchArticlesCompletionHandler?(.failure(.loading))
        mockArticleRepository.fetchArticlesCalledCounter = 0

        // Act
        sut.execute { articles in
        }

        // Assert
        XCTAssertEqual(mockArticleRepository.fetchArticlesCalledCounter, 1)
    }

    func test_Execute_WhenRequestPerformedUnsuccessfullyWithParsingErrorWithinLast5Minutes_ThenFetchArticlesIsCalledAgain() {
        // Arrange
        sut.execute { articles in
        }
        mockArticleRepository.fetchArticlesCompletionHandler?(.failure(.parsing))
        mockArticleRepository.fetchArticlesCalledCounter = 0

        // Act
        sut.execute { articles in
        }

        // Assert
        XCTAssertEqual(mockArticleRepository.fetchArticlesCalledCounter, 1)
    }
}
