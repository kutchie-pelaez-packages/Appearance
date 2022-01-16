import UIKit

public enum AppearanceStyle:
    CustomStringConvertible,
    Equatable
{

    case system
    case custom(AppearanceTheme)

    public var theme: AppearanceTheme {
        switch self {
        case .system:
            let window = UIWindow()
            switch window.traitCollection.userInterfaceStyle {
            case .light:
                return .light

            case .dark:
                return .dark

            case .unspecified:
                return .light

            @unknown default:
                return .light
            }

        case let .custom(theme):
            return theme
        }
    }

    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified

        case let .custom(appearanceTheme):
            return appearanceTheme.userInterfaceStyle
        }
    }

    public var isCustomLight: Bool {
        if
            case let .custom(theme) = self,
            theme == .light
        {
            return true
        }

        return false
    }

    public var isCustomDark: Bool {
        if
            case let .custom(theme) = self,
            theme == .dark
        {
            return true
        }

        return false
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        switch self {
        case .system:
            return "system"

        case let .custom(theme):
            return "custom.\(theme.rawValue)"
        }
    }
}
