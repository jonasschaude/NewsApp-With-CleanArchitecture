import Combine
import UIKit

class ArticleDetailViewModel: ObservableObject {
    var article: ArticleListUiTile
    var urlSession: URLSessionProtocol
    var uiApplicationContainer: UIApplicationContainer

    init(article: ArticleListUiTile, urlSession: URLSessionProtocol = URLSession.shared, uiApplicationContainer: UIApplicationContainer = UIApplicationContainerImpl()) {
        self.article = article
        self.urlSession = urlSession
        self.uiApplicationContainer = uiApplicationContainer
    }
    
    @Published var isImageAvailable: Bool = false
    
    func openArticle() {
        uiApplicationContainer.open(article.url)
    }

    var content: String {
        return article.content
    }
    var headline: String {
        return article.title
    }
    var subheadline: String {
        return article.description
    }
    var published: String {
        let published = article.publishedAt.getFormattedDate(format: "HH:mm E, d MMM y")
        return "\(published) by \(article.author)"
    }
    var title: String {
        return article.title
    }
    @Published var imageData: Data? {
        didSet {
            isImageAvailable = imageData != nil
        }
    }
    var url: URL? {
        return article.url
    }

    func onAppear() {
        loadImage()
    }

    private func loadImage() {
        let task = urlSession.dataTask(with: article.imageUrl) { [weak self] data, _, _ in
            onMainThreadAsync { [weak self] in
                self?.imageData = data
            }
        }
        task.resume()
    }
}
