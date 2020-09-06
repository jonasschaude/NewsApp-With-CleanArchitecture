enum ArticleListViewState {
    case loading
    case success(articles: [ArticleListUiTile])
}
