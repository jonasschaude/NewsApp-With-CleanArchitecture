import UIKit
@testable import NewsApp_With_CleanArchitecture

class MockUIApplicationContainer: UIApplicationContainer {
    var openCalledCounter = 0
    var receivedURL: URL?
    func open(_ url: URL) {
        openCalledCounter += 1
        receivedURL = url
    }
}
