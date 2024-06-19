import Foundation

protocol LaunchScreenAssembler {
    func resolve() -> LaunchScreenRouter
    func resolve(router: LaunchScreenRouter) -> LaunchScreenViewModel
    func resolve(router: LaunchScreenRouter) -> LaunchScreenViewController
}

extension LaunchScreenAssembler {

    func resolve() -> LaunchScreenRouter {
        return LaunchScreenRouter()
    }

    func resolve(router: LaunchScreenRouter) -> LaunchScreenViewController {
        let view = LaunchScreenViewController(
            dependencies: .init(viewModel: resolve(router: router))
        )
        return view
    }
}

extension LaunchScreenAssembler where Self: DefaultAssembler {
    
    func resolve(router: LaunchScreenRouter) -> LaunchScreenViewModel {
        let viewModel = LaunchScreenViewModel(
            dependencies: .init(
                router: router
            )
        )

        return viewModel
    }
}
