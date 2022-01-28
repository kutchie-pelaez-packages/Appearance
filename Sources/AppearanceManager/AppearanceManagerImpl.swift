import AppearanceStyle
import Combine
import Core
import os

private let logger = Logger("appearance")

final class AppearanceManagerImpl: AppearanceManager {
    init() {
        setupUserInterfaceStyleChangeListenerAction()
        subscribeToEvents()
    }

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
                    newAppearanceStyle != self.appearanceStyleSubject.value
                else {
                    return
                }

                logger.log("Changing appearance style from \(self.appearanceStyleSubject.value) to \(newAppearanceStyle)")

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
