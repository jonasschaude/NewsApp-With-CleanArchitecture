import Foundation

func onMainThreadAsync(_ block: @escaping () -> Void) {
    DispatchContainerImpl.shared.onMainThread {
        block()
    }
}

protocol DispatchContainer {
    func onMainThread(_ block: @escaping () -> Void)
}

class DispatchContainerImpl: DispatchContainer {
    static var shared: DispatchContainer = DispatchContainerImpl()

    func onMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
