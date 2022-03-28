import Core
import Foundation

@propertyWrapper
public struct AppearanceStyleUserDefault {
    public init(_ key: String) {
        self._appearanceStyle = UserDefault(key, default: nil)
    }

    @UserDefault
    private var appearanceStyle: String?

    public var wrappedValue: AppearanceStyle {
        get {
            if
                let userDefaultsAppearanceStyleValue = appearanceStyle,
                let theme = AppearanceTheme(rawValue: userDefaultsAppearanceStyleValue)
            {
                return .custom(theme)
            } else {
                return .system
            }
        } set {
            switch newValue {
            case .system: appearanceStyle = nil
            case let .custom(theme): appearanceStyle = theme.rawValue
            }
        }
    }
}
