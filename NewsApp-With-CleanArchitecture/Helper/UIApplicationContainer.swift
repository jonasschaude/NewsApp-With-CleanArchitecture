import UIKit

class UIApplicationContainerImpl: UIApplicationContainer {
    func open(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

protocol UIApplicationContainer {
    func open(_ url: URL)
}
