import Foundation

struct NetworkRepositoryImpl: NetworkRepository {
    
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchRequest(_ url: URL, result: @escaping FetchRequestResult) {
        let dataTask = urlSession.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let urlResponse = urlResponse as? HTTPURLResponse, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((urlResponse, data)))
        }
        dataTask.resume()
    }
}
