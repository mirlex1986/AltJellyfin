import UIKit

struct LaunchScreenModule {
    let view: UIViewController

    init(assembler: Assembler, transition: Transition) {
        let router: LaunchScreenRouter = assembler.resolve()
        let viewController: LaunchScreenViewController = assembler.resolve(router: router)

        view = viewController
        router.viewController = viewController
        router.openTransition = transition
    }
}
