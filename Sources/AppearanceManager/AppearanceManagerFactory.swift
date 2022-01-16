public struct AppearanceManagerFactory {
    public init() { }

    public func produce() -> AppearanceManager {
        AppearanceManagerImpl()
    }
}
