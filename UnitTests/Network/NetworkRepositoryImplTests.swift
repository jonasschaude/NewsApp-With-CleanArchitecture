import XCTest
@testable import NewsApp_With_CleanArchitecture

class NetworkRepositoryImplTests: XCTestCase {
    private var mockURLSession: MockURLSession!
    private var sut: NetworkRepositoryImpl!
    
    override func setUp() {
        mockURLSession = MockURLSession()
        sut = NetworkRepositoryImpl(urlSession: mockURLSession)
    }
    
    func test_FetchRequest__ThenMockURLSessionDataTaskIsCalledOnceWithGivenUrl() {
        // Arrange
        let randomURL = URL(string: "https://www.google.com")!

        // Act
        sut.fetchRequest(randomURL) { _ in
        }

        // Assert
        XCTAssertEqual(mockURLSession.dataTaskCalledCounter, 1)
        XCTAssertEqual(mockURLSession.receivedDataTaskURL?.absoluteString, randomURL.absoluteString)
    }
    
    func test_FetchRequest__ThenCallsResumeOnce() {
        // Arrange
        let mockURLSessionDataTask = MockURLSessionDataTask()
        mockURLSession.dataTaskReturnURLSessionDataTask = mockURLSessionDataTask
        let randomURL = URL(string: "https://www.google.com")!

        // Act
        sut.fetchRequest(randomURL) { _ in
        }
        
        // Assert
        XCTAssertEqual(mockURLSessionDataTask.resumeCalledCounter, 1)
    }
    
    func test_FetchRequest_WhenDataTaskRetrievesError_ThenErrorIsReturned() {
        // Arrange
        let randomURL = URL(string: "https://www.google.com")!
        let error = NSError(domain: "domain", code: 0)

        // Act
        var completionHandlerCalledCounter = 0
        var receivedResult: Result<(HTTPURLResponse, Data), Error>?
        sut.fetchRequest(randomURL) { result in
            completionHandlerCalledCounter += 1
            receivedResult = result
        }
        mockURLSession.receivedDataTaskCompletionHandler?(nil, nil, error)
        
        // Assert
        XCTAssertEqual(completionHandlerCalledCounter, 1)
        var receivedError: Error?
        if case .failure(let error) = receivedResult {
            receivedError = error
        }
        XCTAssertEqual(receivedError?.localizedDescription, error.localizedDescription)
    }

    func test_FetchRequest_WhenDataTaskRetrievesNoUrlResponseAndValidData_ThenErrorIsReturned() {
        // Arrange
        let randomURL = URL(string: "https://www.google.com")!
        let expectedError = NSError(domain: "error", code: 0, userInfo: nil)

        // Act
        var completionHandlerCalledCounter = 0
        var receivedResult: Result<(HTTPURLResponse, Data), Error>?
        sut.fetchRequest(randomURL) { result in
            completionHandlerCalledCounter += 1
            receivedResult = result
        }
        mockURLSession.receivedDataTaskCompletionHandler?(Data(count: 2), nil, nil)
        
        // Assert
        XCTAssertEqual(completionHandlerCalledCounter, 1)
        var receivedError: Error?
        if case .failure(let error) = receivedResult {
            receivedError = error
        }
        XCTAssertEqual(receivedError?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_FetchRequest_WhenDataTaskRetrievesNoDataAndValidHTTPUrlResponse_ThenErrorIsReturned() {
        // Arrange
        let randomURL = URL(string: "https://www.google.com")!
        let expectedError = NSError(domain: "error", code: 0, userInfo: nil)

        // Act
        var completionHandlerCalledCounter = 0
        var receivedResult: Result<(HTTPURLResponse, Data), Error>?
        sut.fetchRequest(randomURL) { result in
            completionHandlerCalledCounter += 1
            receivedResult = result
        }
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.de")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockURLSession.receivedDataTaskCompletionHandler?(nil, urlResponse, nil)
        
        // Assert
        XCTAssertEqual(completionHandlerCalledCounter, 1)
        var receivedError: Error?
        if case .failure(let error) = receivedResult {
            receivedError = error
        }
        XCTAssertEqual(receivedError?.localizedDescription, expectedError.localizedDescription)
    }
    
    func test_FetchRequest_WhenDataTaskRetrievesNoErrorAndValidUrlResponseAndValidData_ThenSuccessIsCalledWithUrlResponseAndData() {
        // Arrange
        let randomURL = URL(string: "https://www.google.com")!

        // Act
        var completionHandlerCalledCounter = 0
        var receivedResult: Result<(HTTPURLResponse, Data), Error>?
        sut.fetchRequest(randomURL) { result in
            completionHandlerCalledCounter += 1
            receivedResult = result
        }
        let urlResponse = HTTPURLResponse(url: URL(string: "https://www.google.de")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let data = Data(count: 1)
        mockURLSession.receivedDataTaskCompletionHandler?(data, urlResponse, nil)
        
        // Assert
        XCTAssertEqual(completionHandlerCalledCounter, 1)
        var receivedHTTPURLResponse: HTTPURLResponse?
        var receivedData: Data?
        if case .success((let httpURLResponse, let data)) = receivedResult {
            receivedHTTPURLResponse = httpURLResponse
            receivedData = data
        }
        XCTAssertEqual(receivedHTTPURLResponse, urlResponse)
        XCTAssertEqual(receivedData, data)
    }
}
