import Appearance
import Core

@propertyWrapper
public struct AppearanceStyleUserDefault {
    @UserDefault
    private var appearanceStyleString: String?

    public var wrappedValue: AppearanceStyle {
        get {
            if
                let appearanceStyleString = appearanceStyleString,
                let theme = AppearanceTheme(rawValue: appearanceStyleString)
            {
                return .custom(theme)
            } else {
                return .system
            }
        } set {
            switch newValue {
            case .system:
                appearanceStyleString = nil

            case .custom(let theme):
                appearanceStyleString = theme.rawValue
            }
        }
    }

    public init(_ key: String) {
        self._appearanceStyleString = UserDefault(key, default: nil)
    }
}
