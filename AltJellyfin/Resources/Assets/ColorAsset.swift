import UIKit

final class ColorAsset {

    // MARK: Public Properties

    let name: String

    lazy var uiColor: UIColor = color(compatibleWith: nil)

    // MARK: Lifecycle

    init(named name: String) {
        self.name = name
    }

    // MARK: Public Methods

    func color(compatibleWith traitCollection: UITraitCollection?) -> UIColor {
        let color = UIColor(
            named: name,
            in: Assets.bundle,
            compatibleWith: traitCollection
        )

        return color ?? .black
    }
}

extension UIColor {
    convenience init?(asset: ColorAsset) {
        self.init(named: asset.name, in: Assets.bundle, compatibleWith: nil)
    }
}
