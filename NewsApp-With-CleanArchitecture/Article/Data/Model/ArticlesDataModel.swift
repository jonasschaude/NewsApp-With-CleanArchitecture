struct ArticlesDataModel {
    let articles: [ArticleItemDataModel]?
}

extension ArticlesDataModel: Decodable {}
