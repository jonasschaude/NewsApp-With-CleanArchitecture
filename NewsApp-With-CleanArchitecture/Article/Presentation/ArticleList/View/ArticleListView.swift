import Combine
import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                VStack {
                    if self.viewModel.isEmpty {
                        Text("No news available.")
                    } else {
                        List(self.viewModel.articles) { article in
                            NavigationLink(destination: self.detailsView(article)) {
                                VStack(alignment: .leading) {
                                    Text(article.title)
                                        .lineLimit(nil)
                                    Text(article.description)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                }
                            }
                        }
                        .listStyle(GroupedListStyle())
                    }
                }
            }
            .navigationBarTitle(viewModel.title)
            .navigationBarItems(trailing:
                Button(action: {
                    self.viewModel.refreshArticles()
                }, label: {
                    Text("Refresh")
                }).disabled(self.viewModel.isLoading)
            )
        }
    }
    
    private func detailsView(_ article: ArticleListUiTile) -> some View {
        let articleDetailViewModel = ArticleDetailViewModel(article: article)
        return ArticleDetailView().environmentObject(articleDetailViewModel)
    }
}

