import Combine
import Core

public protocol AppearanceManager {
    var eventPublisher: AnyPublisher<AppearanceEvent, Never> { get }
    var appearanceStyleSubject: MutableValueSubject<AppearanceStyle> { get }
}

extension AppearanceManager {
    public var appearanceStyle: AppearanceStyle {
        get { appearanceStyleSubject.value }
        set { appearanceStyleSubject.value = newValue }
    }
}
