import UIKit

final class ImageAsset {

    // MARK: Public Properties

    let name: String

    lazy var uiImage: UIImage = image(compatibleWith: nil)

    // MARK: Lifecycle

    init(named name: String) {
        self.name = name
    }

    // MARK: Public Methods

    func image(compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        let image = UIImage(
            named: name,
            in: Assets.bundle,
            compatibleWith: traitCollection
        )

        return image ?? UIImage()
    }
}

extension UIImage {
    convenience init?(asset: ImageAsset) {
        self.init(named: asset.name, in: Assets.bundle, compatibleWith: nil)
    }
}
