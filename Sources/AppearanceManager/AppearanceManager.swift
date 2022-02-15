import AppearanceStyle
import Core
import Tweak

public protocol AppearanceManager: TweakReceiver {
    var eventPublisher: ValuePublisher<AppearanceEvent> { get }
    var appearanceStyleSubject: MutableValueSubject<AppearanceStyle> { get }
}
