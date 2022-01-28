import AppearanceStyle
import Combine
import Core
import os

private let logger = Logger("appearance")

final class AppearanceManagerImpl: AppearanceManager {
    init() {
        setupUserInterfaceStyleChangeListenerAction()
    }

    @AppearanceStyleUserDefault("appearance_style")
    private var storedAppearanceStyle
    private lazy var cachedAppearanceStyle = storedAppearanceStyle

    private var appearanceThemeReceivers = WeakArray<AppearanceThemeReceiver>()

    private let eventPassthroughSubject = PassthroughSubject<AppearanceEvent, Never>()
    private let userInterfaceStyleChangeListenerWindow = UserInterfaceStyleChangeListenerWindow()

    // MARK: -

    private func setupUserInterfaceStyleChangeListenerAction() {
        userInterfaceStyleChangeListenerWindow.userInterfaceStyleDidChangeAction = { [weak self] in
            self?.eventPassthroughSubject.send(.systemUserInterfaceStyleDidChange)
        }
    }

    private func sendCurrentAppearanceThemeToReceivers() {
        appearanceThemeReceivers.forEach {
            $0.receive(appearanceStyle.theme)
        }
    }

    // MARK: - Startable

    func start() {
        sendCurrentAppearanceThemeToReceivers()
    }

    // MARK: - AppearanceManager

    var eventPublisher: ValuePublisher<AppearanceEvent> {
        eventPassthroughSubject
            .eraseToAnyPublisher()
    }

    var appearanceStyle: AppearanceStyle {
        get {
            cachedAppearanceStyle
        } set {
            guard appearanceStyle != newValue else { return }

            logger.log("Changing appearance style from \(self.appearanceStyle) to \(newValue)")

            storedAppearanceStyle = newValue
            cachedAppearanceStyle = newValue

            if appearanceStyle.theme != newValue.theme {
                sendCurrentAppearanceThemeToReceivers()
            }
        }
    }

    func register(appearanceThemeReceiver: AppearanceThemeReceiver) {
        appearanceThemeReceiver.receive(appearanceStyle.theme)
        appearanceThemeReceivers.append(appearanceThemeReceiver)
    }
}
