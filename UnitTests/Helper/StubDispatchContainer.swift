@testable import NewsApp_With_CleanArchitecture

class StubDispatcher: DispatchContainer {
    func onMainThread(_ block: @escaping () -> Void) {
        block()
    }
}
