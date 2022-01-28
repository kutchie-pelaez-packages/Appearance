import AppearanceStyle
import Core

public protocol AppearanceManager {
    var eventPublisher: ValuePublisher<AppearanceEvent> { get }
    var appearanceStyleSubject: MutableValueSubject<AppearanceStyle> { get }
}
