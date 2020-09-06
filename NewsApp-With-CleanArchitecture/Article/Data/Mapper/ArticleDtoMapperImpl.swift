import Foundation

struct ArticleDtoMapperImpl: ArticleDtoMapper {
    func map(_ data: ArticlesDataModel) -> [ArticleEntity] {
        var result: [ArticleEntity] = []
        guard let articles = data.articles else {
            return []
        }
        for article in articles {
            guard let urlAsString = article.url, let imageUrlAsString = article.urlToImage, let url = URL(string: urlAsString), let imageUrl = URL(string: imageUrlAsString), let title = article.title, let description = article.description, let publishedAt = article.publishedAt?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ"), let content = article.content else {
                continue
            }
            let articleEntity = ArticleEntity(author: article.author ?? "", content: content, title: title, description: description, url: url, imageUrl: imageUrl, publishedAt: publishedAt)
            result.append(articleEntity)
        }
        return result
    }
}
