struct ArticleListUiTileMapperImpl: ArticleListUiTileMapper {
    func map(_ articles: [ArticleEntity]) -> [ArticleListUiTile] {
        var result: [ArticleListUiTile] = []
        for article in articles {
            result.append(ArticleListUiTile(article: article))
        }
        return result
    }
}
