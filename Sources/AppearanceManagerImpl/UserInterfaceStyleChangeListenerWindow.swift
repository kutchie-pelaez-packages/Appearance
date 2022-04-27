import Core
import UIKit

final class UserInterfaceStyleChangeListenerWindow: UIWindow {
    var userInterfaceStyleDidChangeAction: ActionWith<UIUserInterfaceStyle>?

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let newUserInterfaceStyle = traitCollection.userInterfaceStyle
        let previousUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle

        guard newUserInterfaceStyle != previousUserInterfaceStyle else { return }

        userInterfaceStyleDidChangeAction?(newUserInterfaceStyle)
    }
}
