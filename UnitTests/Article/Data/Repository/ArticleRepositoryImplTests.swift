import XCTest
@testable import NewsApp_With_CleanArchitecture

class ArticleRepositoryImplTests: XCTestCase {
    var sut: ArticleRepositoryImpl!
    var mockNetworkRepository: MockNetworkRepository!
    var mockArticleDtoMapper: MockArticleDtoMapper!
    var mockNewsApiFactory: MockNewsApiFactory!
    var mockJSONDecoder: MockJSONDecoder!
    
    override func setUp() {
        mockNetworkRepository = MockNetworkRepository()
        mockArticleDtoMapper = MockArticleDtoMapper()
        mockNewsApiFactory = MockNewsApiFactory()
        mockJSONDecoder = MockJSONDecoder()
        sut = ArticleRepositoryImpl(networkRepository: mockNetworkRepository, articleDtoMapper: mockArticleDtoMapper, jsonDecoder: mockJSONDecoder, newsApiFactory: mockNewsApiFactory)
    }
    
    func testFetchArticles__NewsApiFactoryCreateTopHeadlinesUrlIsCalledOnce() {
        // Act
        sut.fetchArticles { result in
        }
        
        // Assert
        XCTAssertEqual(mockNewsApiFactory.createTopHeadlinesUrlCalledCounter, 1)
    }
    
    func testFetchArticles__NetworkRepositoryFetchRequestIsCalledOnceWithGeneratedUrl() {
        // Arrange
        mockNewsApiFactory.urlComponents = URLComponents(string: "http://www.example.com")!
        
        // Act
        sut.fetchArticles { result in
        }
        
        // Assert
        XCTAssertEqual(mockNetworkRepository.fetchRequestCalledCounter, 1)
        XCTAssertEqual(mockNetworkRepository.receivedURL, URL(string: "http://www.example.com")!)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsFailure_CompletionHandlerIsCalledWithLoadingFailure() {
        // Arrange
        mockNewsApiFactory.urlComponents = URLComponents()
        let error = NSError(domain: "", code: 0, userInfo: nil)
        var failureLoadingCalledCounter = 0
        
        // Act
        sut.fetchArticles { result in
            switch result {
            case .failure(let error):
                switch error {
                case .loading:
                    failureLoadingCalledCounter += 1
                default:
                    break
                }
            default:
                break
            }
        }
        mockNetworkRepository.receivedCompletionHandler?(.failure(error))
        
        // Assert
        XCTAssertEqual(failureLoadingCalledCounter, 1)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsStatusCodeUnequalOk_CompletionHandlerIsCalledWithLoadingFailure() {
        // Arrange
        mockNewsApiFactory.urlComponents = URLComponents()
        var failureLoadingCalledCounter = 0
        
        // Act
        sut.fetchArticles { result in
            switch result {
            case .failure(let error):
                switch error {
                case .loading:
                    failureLoadingCalledCounter += 1
                default:
                    break
                }
            default:
                break
            }
        }
        mockNetworkRepository.receivedCompletionHandler?(.success((HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 199, httpVersion: nil, headerFields: nil)!, Data())))
        
        // Assert
        XCTAssertEqual(failureLoadingCalledCounter, 1)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsStatusCodeOkAndUnparsableData_CompletionHandlerIsCalledWithParsingFailure() {
        // Arrange
        let data = "".data(using: .utf8)!
        mockNewsApiFactory.urlComponents = URLComponents()
        var failureParsingCalledCounter = 0
        
        // Act
        sut.fetchArticles { result in
            switch result {
            case .failure(let error):
                switch error {
                case .parsing:
                    failureParsingCalledCounter += 1
                default:
                    break
                }
            default:
                break
            }
        }
        mockNetworkRepository.receivedCompletionHandler?(.success((HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data)))
        
        // Assert
        XCTAssertEqual(failureParsingCalledCounter, 1)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsStatusCodeOk_JsonDecoderIsCalledOnce() {
        // Arrange
        let data = "test".data(using: .utf8)!
        mockNewsApiFactory.urlComponents = URLComponents()
        
        // Act
        sut.fetchArticles { result in
        }
        mockNetworkRepository.receivedCompletionHandler?(.success((HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data)))
        
        // Assert
        XCTAssertEqual(mockJSONDecoder.decodeWithErrorHandlingCalledCounter, 1)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsStatusCodeOkAndParsingFailes_CallbackCalledWithParsingError() {
        // Arrange
        let data = "test".data(using: .utf8)!
        mockNewsApiFactory.urlComponents = URLComponents()
        var parsingErrorCalledCounter = 0
        
        // Act
        sut.fetchArticles { result in
            switch result {
            case .failure(let error):
                switch error {
                case .parsing:
                    parsingErrorCalledCounter += 1
                default:
                    break
                }
            default:
                break
            }
        }
        mockNetworkRepository.receivedCompletionHandler?(.success((HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data)))
        
        // Assert
        XCTAssertEqual(parsingErrorCalledCounter, 1)
    }
    
    func testFetchArticles_NetworkRepositoryFetchRequestReturnsStatusCodeOkAndParsingReturnsSuccess_CompletionHandlerIsCalledWithParsedObject() {
        // Arrange
        let data = "test".data(using: .utf8)!
        mockNewsApiFactory.urlComponents = URLComponents()
        var successCalledCounter = 0
        var receivedArticleEntity: [ArticleEntity]?
        let articleEntities = [ArticleEntityBuilder.new().with(title: "uniqueTitle123").build()]
        mockArticleDtoMapper.articleEntities = articleEntities
        mockJSONDecoder.result = .success(ArticlesDataModelBuilder.new().build())
        
        // Act
        sut.fetchArticles { result in
            switch result {
            case .success(let result):
                successCalledCounter += 1
                receivedArticleEntity = result
            default:
                break
            }
        }
        mockNetworkRepository.receivedCompletionHandler?(.success((HTTPURLResponse(url: URL(string: "www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!, data)))
        
        // Assert
        XCTAssertEqual(successCalledCounter, 1)
        XCTAssertEqual(receivedArticleEntity, articleEntities)
    }
}
