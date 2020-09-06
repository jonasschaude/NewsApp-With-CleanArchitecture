import Foundation

typealias FetchRequestResult = (_ result: Result<(HTTPURLResponse, Data), Error>) -> Void

protocol NetworkRepository {
    func fetchRequest(_ url: URL, result: @escaping FetchRequestResult)
}
