import Logger

public struct AppearanceManagerFactory {
    public init() { }

    public func produce(logger: Logger) -> AppearanceManager {
        AppearanceManagerImpl(logger: logger)
    }
}
