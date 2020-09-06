import SwiftUI
import Combine

struct ArticleDetailView: View {
    
    @EnvironmentObject var viewModel: ArticleDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.article.title)
                    .font(.headline)
                if viewModel.isImageAvailable {
                    Image(uiImage: imageFromData())
                        .resizable()
                        .scaledToFit()
                }
                Text(viewModel.published).font(.footnote)
                Text(viewModel.article.content)
                    .font(.body)
                Button(action: {
                    self.viewModel.openArticle()
                }) {
                    Text("Read more...")
                }
            }
            .padding()
        }
        .onAppear {
            self.viewModel.onAppear()
        }
        .navigationBarTitle(viewModel.title)
    }
    
    private func imageFromData() -> UIImage {
        guard let data = viewModel.imageData, let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
