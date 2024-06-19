import Foundation

protocol LaunchScreenRoute {
    func showLaunchScreenScene()
}

extension LaunchScreenRoute where Self: RouterProtocol {
    func showLaunchScreenScene() {
        let transition = WindowNavigationTransition()
        
        let module = LaunchScreenModule(
            assembler: DefaultAssembler.shared,
            transition: transition
        )
        open(module.view, transition: transition)
    }
}
