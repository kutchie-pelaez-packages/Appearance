import Core
import UIKit

final class UserInterfaceStyleChangeListenerWindow: UIWindow {
    var userInterfaceStyleDidChangeAction: Block?

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }

        userInterfaceStyleDidChangeAction?()
    }
}
