import Foundation

protocol AuthScreenAssembler {
    func resolve() -> AuthScreenRouter
    func resolve(router: AuthScreenRouter) -> AuthScreenViewModel
    func resolve(router: AuthScreenRouter) -> AuthScreenViewController
}

extension AuthScreenAssembler {

    func resolve() -> AuthScreenRouter {
        return AuthScreenRouter()
    }

    func resolve(router: AuthScreenRouter) -> AuthScreenViewController {
        let view = AuthScreenViewController(
            dependencies: .init(viewModel: resolve(router: router))
        )
        return view
    }
}

extension AuthScreenAssembler where Self: DefaultAssembler {
    
    func resolve(router: AuthScreenRouter) -> AuthScreenViewModel {
        let viewModel = AuthScreenViewModel(
            dependencies: .init(
                router: router
            )
        )

        return viewModel
    }
}
