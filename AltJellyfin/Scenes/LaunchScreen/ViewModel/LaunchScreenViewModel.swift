import Foundation
import Combine

final class LaunchScreenViewModel {
    private let router: LaunchScreenRouter
    
    private var cancellables = Set<AnyCancellable>()

    init(dependencies: Dependencies) {
        router = dependencies.router
    }

    func bind(input: Input) -> Output {
        handleAppStarted(with: input.appStarted)
        return Output()
    }
}

// MARK: - Private

private extension LaunchScreenViewModel {

    func handleAppStarted(with publisher: AnyPublisher<Void, Never>) {
        publisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                // TODO: Keychain
                if (UserDefaultsManager.getValueForKey(.user) != nil) {
                    print("route to home")
                } else {
                    self.router.showAuthScreenScene()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - DI Container

extension LaunchScreenViewModel {

    struct Dependencies {
        let router: LaunchScreenRouter
    }

    struct Input {
        let appStarted: AnyPublisher<Void, Never>
    }

    struct Output {
    }
}
