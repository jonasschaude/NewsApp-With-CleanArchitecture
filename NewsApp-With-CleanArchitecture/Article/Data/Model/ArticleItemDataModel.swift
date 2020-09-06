struct ArticleItemDataModel {
    let author: String?
    let content: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

extension ArticleItemDataModel: Decodable {}
