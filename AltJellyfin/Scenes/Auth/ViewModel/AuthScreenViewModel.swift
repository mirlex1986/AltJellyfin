import Foundation
import Combine

final class AuthScreenViewModel {
    private let router: AuthScreenRouter
    
    private var cancellables = Set<AnyCancellable>()

    init(dependencies: Dependencies) {
        router = dependencies.router
    }

    func bind(input: Input) -> Output {
        return Output()
    }
}

// MARK: - Private

private extension AuthScreenViewModel {
}

// MARK: - DI Container

extension AuthScreenViewModel {

    struct Dependencies {
        let router: AuthScreenRouter
    }

    struct Input {
    }

    struct Output {
    }
}
