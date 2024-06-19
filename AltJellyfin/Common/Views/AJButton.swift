import UIKit

class AJButton: UIButton {
    
    // MARK: - UI
    private var loader: UIImageView = {
        let view = UIImageView()
        view.image = Assets.Images.loader.uiImage
        view.isHidden = true
        return view
    }()
    
    // MARK: - Properties
    private var options: Set<ButtonOptions>!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(options: Set<ButtonOptions>) {
        super.init(frame: .zero)
        self.options = options
        
        setupDefaultConfig()
        addLoader()
        setupConstraints()
        
        options.forEach { configure(option: $0) }
        
        layoutIfNeeded()
    }
    
    func configure(option: ButtonOptions) {
        switch option {
        case .style(let type):
            switch type {
            case .bordered:
                layer.borderWidth = 1
                layer.borderColor = Assets.Colors.lightGrayText.uiColor.cgColor

            case .simple:
                break
                
            case .disabled:
                backgroundColor = .lightGray
                setTitleColor(.white, for: .normal)
            }
            
        case .title(let title):
            isUserInteractionEnabled = true
            loader.isHidden = true
            loader.stopRotating()
            titleLabel?.isHidden = false
            setTitle(title, for: .normal)
            
        case .loading:
            isUserInteractionEnabled = false
            loader.isHidden = false
            loader.rotate()
            titleLabel?.isHidden = true
        }
    }
}

private extension AJButton {
    func setupDefaultConfig() {
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        setTitleColor(Assets.Colors.buttonTextColor.uiColor, for: .normal)
        titleLabel?.numberOfLines = 1
        
        backgroundColor = Assets.Colors.buttonBackground.uiColor
        
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    func addLoader() {
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 16).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }
}

enum ButtonOptions: Hashable {
    case loading
    case style(type: ButtonStyle)
    case title(_ title: String)
}

enum ButtonStyle: String {
    case bordered
    case simple

    case disabled
}
