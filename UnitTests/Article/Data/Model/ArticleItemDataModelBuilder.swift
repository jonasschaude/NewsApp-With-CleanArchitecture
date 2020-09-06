@testable import NewsApp_With_CleanArchitecture

class ArticleItemDataModelBuilder {
    private var author: String?
    private var content: String?
    private var title: String?
    private var description: String?
    private var url: String?
    private var urlToImage: String?
    private var publishedAt: String?
    
    static func new() -> ArticleItemDataModelBuilder {
        return ArticleItemDataModelBuilder()
    }
    
    func with(author: String) -> ArticleItemDataModelBuilder {
        self.author = author
        return self
    }
    
    func with(content: String) -> ArticleItemDataModelBuilder {
        self.content = content
        return self
    }
    
    func with(title: String) -> ArticleItemDataModelBuilder {
        self.title = title
        return self
    }
    
    func with(description: String) -> ArticleItemDataModelBuilder {
        self.description = description
        return self
    }
    
    func with(url: String) -> ArticleItemDataModelBuilder {
        self.url = url
        return self
    }
    
    func with(urlToImage: String) -> ArticleItemDataModelBuilder {
        self.urlToImage = urlToImage
        return self
    }
    
    func with(publishedAt: String) -> ArticleItemDataModelBuilder {
        self.publishedAt = publishedAt
        return self
    }
    
    func build() -> ArticleItemDataModel {
        ArticleItemDataModel(author: author, content: content, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
    }
}
