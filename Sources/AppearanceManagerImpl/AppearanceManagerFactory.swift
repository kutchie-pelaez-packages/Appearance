import Appearance
import Logger
import Tweaking

public struct AppearanceManagerFactory {
    public init() { }

    public func produce(logger: Logger) -> AppearanceManager & TweakReceiver {
        AppearanceManagerImpl(logger: logger)
    }
}
