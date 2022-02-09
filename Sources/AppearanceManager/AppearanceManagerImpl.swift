import AppearanceStyle
import Combine
import Core
import Logger

final class AppearanceManagerImpl: AppearanceManager {
    init(logger: Logger) {
        self.logger = logger
        setupUserInterfaceStyleChangeListenerAction()
        subscribeToEvents()
    }

    private let logger: Logger

    @AppearanceStyleUserDefault("appearance_style")
    private var storedAppearanceStyle

    private let userInterfaceStyleChangeListenerWindow = UserInterfaceStyleChangeListenerWindow()

    private let eventPassthroughSubject = ValuePassthroughSubject<AppearanceEvent>()
    private var cancellables = [AnyCancellable]()

    // MARK: -

    private func setupUserInterfaceStyleChangeListenerAction() {
        userInterfaceStyleChangeListenerWindow.userInterfaceStyleDidChangeAction = { [weak self] in
            self?.eventPassthroughSubject.send(.systemUserInterfaceStyleDidChange)
        }
    }

    private func subscribeToEvents() {
        appearanceStyleSubject
            .sink { [weak self] newAppearanceStyle in
                guard
                    let self = self,
                    newAppearanceStyle != self.storedAppearanceStyle
                else {
                    return
                }

                self.logger.log(
                    "Changing appearance style from \(self.appearanceStyleSubject.value) to \(newAppearanceStyle)",
                    domain: .appearance
                )

                self.storedAppearanceStyle = newAppearanceStyle
            }
            .store(in: &cancellables)
    }

    // MARK: - AppearanceManager

    var eventPublisher: ValuePublisher<AppearanceEvent> {
        eventPassthroughSubject.eraseToAnyPublisher()
    }

    lazy var appearanceStyleSubject: MutableValueSubject<AppearanceStyle> = UniqueMutableValueSubject(storedAppearanceStyle)
}

extension LogDomain {
    fileprivate static let appearance: Self = "appearance"
}
