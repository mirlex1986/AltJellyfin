import UIKit
import Combine

final class AuthScreenViewController: AJViewController {
    
    private let vStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.distribution = .fill
        view.axis = .vertical
        return view
    }()
    
    private let addressInput: AJInputView = {
        let view = AJInputView()
        view.configure(type: .serverAddress, string: nil)
        return view
    }()
    
    private let userInput: AJInputView = {
        let view = AJInputView()
        view.configure(type: .name, string: nil)
        return view
    }()
    
    private let passwordInput: AJInputView = {
        let view = AJInputView()
        view.configure(type: .password, string: nil)
        return view
    }()
    
    private let confirmButton = AJButton(options: [.style(type: .disabled), .title("Подключиться")])

    private var viewModel: AuthScreenViewModel

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

    }
}

// MARK: - Private

private extension AuthScreenViewController {
    
    func makeUI() {
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(addressInput)
        vStackView.addArrangedSubview(userInput)
        vStackView.addArrangedSubview(passwordInput)
        vStackView.addArrangedSubview(confirmButton)
    }

    func setupConstraints() {
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

    
    func subscribe() {
        let input = AuthScreenViewModel.Input(
        )

        _ = viewModel.bind(input: input)
    }
}

// MARK: - DI Container

extension AuthScreenViewController {

    struct Dependencies {
        let viewModel: AuthScreenViewModel
    }
}
