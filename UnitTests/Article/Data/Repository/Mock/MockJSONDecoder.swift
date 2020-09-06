import Foundation
@testable import NewsApp_With_CleanArchitecture

class MockJSONDecoder: JSONDecoderProtocol {
    var result: Result<ArticlesDataModel, Error>? = .failure(NSError(domain: "", code: 0, userInfo: nil))
    var decodeWithErrorHandlingCalledCounter = 0
    var retrievedData: Data?
    func decodeWithErrorHandling<T>(_ type: T.Type, from data: Data) -> (Result<T, Error>) where T : Decodable {
        decodeWithErrorHandlingCalledCounter += 1
        retrievedData = data
        return result as! Result<T, Error>
    }
}
