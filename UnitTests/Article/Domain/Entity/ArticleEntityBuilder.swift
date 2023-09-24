import Foundation
@testable import NewsApp_With_CleanArchitecture

class ArticleEntityBuilder {
    private var author: String = ""
    private var content: String = ""
    private var title: String = ""
    private var description: String = ""
    private var url: URL = URL(string: "https://www.google.de")!
    private var imageURL: URL = URL(string: "https://www.google.de")!
    private var publishedAt: Date = Date()
    
    static func new() -> ArticleEntityBuilder {
        return ArticleEntityBuilder()
    }
    
    func with(author: String) -> ArticleEntityBuilder {
        self.author = author
        return self
    }
    
    func with(content: String) -> ArticleEntityBuilder {
        self.content = content
        return self
    }
    
    func with(title: String) -> ArticleEntityBuilder {
        self.title = title
        return self
    }
    
    func with(description: String) -> ArticleEntityBuilder {
        self.description = description
        return self
    }
    
    func with(url: URL) -> ArticleEntityBuilder {
        self.url = url
        return self
    }
    
    func with(imageURL: URL) -> ArticleEntityBuilder {
        self.imageURL = imageURL
        return self
    }
    
    func with(publishedAt: Date) -> ArticleEntityBuilder {
        self.publishedAt = publishedAt
        return self
    }

    func build() -> ArticleEntity {
        return ArticleEntity(
            author: author,
            content: content,
            title: title,
            description: description,
            url: url,
            imageUrl: imageURL,
            publishedAt: publishedAt
        )
    }
}
