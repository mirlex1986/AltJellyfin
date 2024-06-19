import UIKit

struct AuthScreenModule {
    let view: UIViewController

    init(assembler: Assembler, transition: Transition) {
        let router: AuthScreenRouter = assembler.resolve()
        let viewController: AuthScreenViewController = assembler.resolve(router: router)

        view = viewController
        router.viewController = viewController
        router.openTransition = transition
    }
}
