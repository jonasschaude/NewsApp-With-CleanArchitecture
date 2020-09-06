import Foundation

class ArticleListUiTile {
    let author: String
    let content: String
    let title: String
    let description: String
    let url: URL
    let imageUrl: URL
    let publishedAt: Date
    init(article: ArticleEntity) {
        self.author = article.author
        self.content = article.content
        self.title = article.title
        self.description = article.description
        self.url = article.url
        self.imageUrl = article.imageUrl
        self.publishedAt = article.publishedAt
    }
}

extension ArticleListUiTile: Identifiable {}

extension ArticleListUiTile: Equatable {
    static func == (lhs: ArticleListUiTile, rhs: ArticleListUiTile) -> Bool {
        return lhs.author == rhs.author &&
            lhs.content == rhs.content &&
            lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.url == rhs.url &&
            lhs.imageUrl == rhs.imageUrl &&
            lhs.publishedAt == rhs.publishedAt
    }
}
