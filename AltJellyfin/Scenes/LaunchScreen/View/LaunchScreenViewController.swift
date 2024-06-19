import UIKit
import Combine

final class LaunchScreenViewController: AJViewController {
    
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.image = Assets.Images.jellyfinLogo.uiImage
        return view
    }()

    private let appStartedSignal = PassthroughSubject<Void, Never>()
    private var viewModel: LaunchScreenViewModel

    init(dependencies: Dependencies) {
        self.viewModel = dependencies.viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        subscribe()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateLogo()
    }
}

// MARK: - Private

private extension LaunchScreenViewController {
    
    func makeUI() {
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
    }

    func setupConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 128).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 128).isActive = true
    }

    
    func subscribe() {
        let input = LaunchScreenViewModel.Input(
            appStarted: appStartedSignal.eraseToAnyPublisher()
        )

        _ = viewModel.bind(input: input)
    }

    func animateLogo() {
        let animator = UIViewPropertyAnimator(duration: 2, curve: .linear) {
            self.logoImage.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }

        animator.startAnimation()

        animator.addCompletion { _ in
            UIView.animate(withDuration: 0.5) {
                self.logoImage.transform = CGAffineTransform.identity
            } completion: { _ in
                self.appStartedSignal.send()
            }
        }
    }
}

// MARK: - DI Container

extension LaunchScreenViewController {

    struct Dependencies {
        let viewModel: LaunchScreenViewModel
    }
}
