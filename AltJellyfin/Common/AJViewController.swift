import UIKit

class AJViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSystemNavigationBar()
        view.backgroundColor = Assets.Colors.appBackground.uiColor
    }
}

private extension AJViewController {

    func hideSystemNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
