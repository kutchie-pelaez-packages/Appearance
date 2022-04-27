import Appearance
import AppearanceTweaking
import Combine
import Core
import Logger
import Tweaking

final class AppearanceManagerImpl: AppearanceManager, TweakReceiver {
    private let logger: Logger

    @AppearanceStyleUserDefault("appearance_style")
    private var storedAppearanceStyle

    private let userInterfaceStyleChangeListenerWindow = UserInterfaceStyleChangeListenerWindow()

    private let eventPassthroughSubject = PassthroughSubject<AppearanceEvent, Never>()
    private var cancellables = [AnyCancellable]()

    init(logger: Logger) {
        self.logger = logger
        setupUserInterfaceStyleChangeListenerAction()
        subscribeToEvents()
    }

    private func setupUserInterfaceStyleChangeListenerAction() {
        userInterfaceStyleChangeListenerWindow.userInterfaceStyleDidChangeAction = { [weak self] userInterfaceStyle in
            self?.eventPassthroughSubject.send(.systemUserInterfaceStyleDidChange(userInterfaceStyle))
        }
    }

    private func subscribeToEvents() {
        appearanceStyleSubject
            .sink { [weak self] newAppearanceStyle in
                guard let self = self, newAppearanceStyle != self.storedAppearanceStyle else {
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

    var eventPublisher: AnyPublisher<AppearanceEvent, Never> {
        eventPassthroughSubject.eraseToAnyPublisher()
    }

    lazy var appearanceStyleSubject = MutableValueSubject(storedAppearanceStyle)

    // MARK: - TweakReceiver

    func receive(_ tweak: Tweak) {
        guard
            tweak.id == .Appearance.update,
            let newValue = tweak.args[.newValue] as? AppearanceStyle
        else {
            return
        }

        appearanceStyleSubject.value = newValue
    }
}

extension LoggingDomain {
    fileprivate static let appearance: LoggingDomain = "appearance"
}
