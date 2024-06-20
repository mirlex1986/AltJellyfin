import UIKit
import Combine

enum InputType {
    case name
    case password
    case serverAddress
    
    var placeholderText: String {
        switch self {
        case .name:
            return "name"
        case .password:
            return "password"
        case .serverAddress:
            return "serverAddress"
        }
    }
}

final class AJInputView: UIView {

    // MARK: - UI

    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.textColor = Assets.Colors.lightGrayText.uiColor
        return textField
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Assets.Colors.buttonTextColor.uiColor
        label.isUserInteractionEnabled = false
        return label
    }()

    // MARK: - Properties

    var stringType: InputType?
    let textPublisher = CurrentValueSubject<String?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(type: InputType, string: String?) {
        stringType = type
        
        inputTextField.text = string
        placeholderLabel.text = type.placeholderText
        checkVisibilities(type: type, string: string)
    }
}

// MARK: - Private

private extension AJInputView {

    func setupUI() {
        backgroundColor = .clear
        inputTextField.backgroundColor = Assets.Colors.TextField.background.uiColor

        setupViews()
        setupConstraints()
        makeBorder(active: false)
    }

    func setupViews() {
        addSubviews(
            inputTextField,
            placeholderLabel
        )
        
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        inputTextField.leftViewMode = .always
    }

    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    func makeBorder(active: Bool) {
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = active ? UIColor.clear.cgColor : Assets.Colors.TextField.blueBorder.uiColor.cgColor
        inputTextField.layer.cornerRadius = 16
    }

    func checkVisibilities(type: InputType?, string: String?) {
        makeBorder(active: string.isNilOrEmpty && !self.inputTextField.isFirstResponder)
        animateLabels(string.isNilOrEmpty && !self.inputTextField.isFirstResponder)
    }
    
    func animateLabels(_ value: Bool) {
        if !value, inputTextField.text?.isEmpty == true {
            UIView.animate(withDuration: 0.2) {
                let move = CGAffineTransform(
                    translationX: 0,
                    y: self.inputTextField.frame.minY - self.placeholderLabel.frame.height
                )
                let size = CGAffineTransform(scaleX: 1, y: 1)
                self.placeholderLabel.transform = size.concatenating(move)
            }
        } else {
            if inputTextField.text?.isEmpty == true {
                UIView.animate(withDuration: 0.2) {
                    self.placeholderLabel.transform = .identity
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension AJInputView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkVisibilities(type: stringType, string: textField.text)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        checkVisibilities(type: stringType, string: textField.text)
        textPublisher.send(textField.text)
    }
}
