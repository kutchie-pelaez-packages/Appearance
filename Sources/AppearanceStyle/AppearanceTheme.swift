import UIKit

public enum AppearanceTheme: String, CaseIterable, CustomStringConvertible {
    case light
    case dark

    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light

        case .dark:
            return .dark
        }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        rawValue
    }
}
