import Foundation

protocol JSONDecoderProtocol {
    func decodeWithErrorHandling<T>(_ type: T.Type, from data: Data) -> (Result<T, Error>) where T: Decodable
}

extension JSONDecoder: JSONDecoderProtocol {
    func decodeWithErrorHandling<T>(_ type: T.Type, from data: Data) -> (Result<T, Error>) where T: Decodable {
        var errorDescription = ""
        do {
            return .success(try JSONDecoder().decode(type, from: data))
        } catch let DecodingError.typeMismatch(_, context) {
            errorDescription += "\(context.debugDescription) \(context.codingPath)"
        } catch let DecodingError.dataCorrupted(context) {
            errorDescription += "\(context.debugDescription) \(context.codingPath)"
        } catch let error as NSError {
            errorDescription += "\(error.debugDescription)"
        }
        let error = NSError(domain: "", code: 0, userInfo: [
            NSLocalizedDescriptionKey: "Could not parse data to \(type.self). Error: \(errorDescription)"
        ])
        return .failure(error)
    }
}
