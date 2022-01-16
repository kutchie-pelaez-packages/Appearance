import AppearanceStyle
import CoreUtils

public protocol AppearanceManager: Startable {
    var eventPublisher: ValuePublisher<AppearanceEvent> { get }
    var appearanceStyle: AppearanceStyle { get nonmutating set }
    func register(appearanceThemeReceiver: AppearanceThemeReceiver)
}
