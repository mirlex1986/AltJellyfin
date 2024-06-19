import UIKit

public final class WindowNavigationTransition: NSObject {
    public weak var viewController: UIViewController?
}

// MARK: - Transition

extension WindowNavigationTransition: Transition {

    public func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else { return }

        let navCon = UINavigationController(rootViewController: viewController)
        navCon.isNavigationBarHidden = true

        window?.rootViewController = navCon
        UIView.transition(
            with: window ?? UIWindow(),
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: { _ in
            }
        )
        window?.makeKeyAndVisible()
    }

    public func close(_ viewController: UIViewController) { }
}
