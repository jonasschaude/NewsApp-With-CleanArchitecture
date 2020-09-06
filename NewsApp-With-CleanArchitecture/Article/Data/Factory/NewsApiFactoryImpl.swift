import Foundation

struct NewsApiFactoryImpl: NewsApiFactory {
    
    // You can sign up for a api token on https://newsapi.org/register
    let apiKey = ""
    
    func createTopHeadlinesUrl() -> URLComponents {
        let countryCode = Locale.current.regionCode ?? "en"
        var components = URLComponents()
        components.scheme = "http"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
          URLQueryItem(name: "country", value: countryCode),
          URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return components
    }
}
