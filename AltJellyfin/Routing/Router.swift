import UIKit

public protocol Closable: AnyObject {
    func close()
}

public protocol RouterProtocol: AnyObject {
    associatedtype GenericController: UIViewController
    var viewController: GenericController? { get }
    var openTransition: Transition? { get set }

    func open(_ viewController: UIViewController, transition: Transition)
    func close()
}

open class Router<GVC>: RouterProtocol, Closable where GVC: UIViewController {
    public typealias GenericController = GVC

    public weak var viewController: GenericController?
    public var openTransition: Transition?

    public init() { }

    public func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    public func close() {
        guard
            let openTransition = openTransition
        else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }

        guard
            let viewController = viewController
        else {
            assertionFailure("Nothing to close.")
            return
        }

        openTransition.close(viewController)
    }
}
