import UIKit

protocol AppRouter: Closable, LaunchScreenRoute { }

final class AppRouterImpl: Router<UIViewController>, AppRouter {}
