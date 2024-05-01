//
//  ViewModel.swift
//
//
//  Created by Coleton Gorecke on 11/16/23.
//

import Foundation
import Combine
import SwiftUI

/// The ViewModel object to be used by ViewModels. Open for additional subclassing if needed.
@MainActor open class ViewModel<State: ViewState>: ObservableObject {
    /// Set of Combine cancellables used to manage asynchronous tasks.
    public var cancellables = Set<AnyCancellable>()
    
    /// Published property representing the state of the ViewModel.
    @Published open var state = State()
    
    /// Initializes a new instance of this type.
    public required nonisolated init() {}
    
    /// Configures the ViewModel. Override this method to provide configuration logic.
    /// Default implementation is empty
    open func configure() { }
    
    open func dismiss() {
        dismissSubject.send()
    }
    
    var dismissPublisher: AnyPublisher<Void, Never> {
        dismissSubject.eraseToAnyPublisher()
    }
    
    private var dismissSubject = PassthroughSubject<Void, Never>()
}

/// A protocol representing the state of a View.
public protocol ViewState {
    /// Initializes a new instance of this type.
    init()
}

/// A protocol representing the content of a View.
public protocol ViewContent: View {
    /// Associated type representing the state type of the content.
    associatedtype State = ViewState
    
    /// Initializes a new instance of the ViewContent.
    init(state: Binding<State>)
}

/// A view that binds a ``ViewModel`` to a ``ViewContent`` type.
///
/// Use as is, or copy this stack and rename to apply EnvironmentObjects to any view that this is used in.
public struct ViewStack<
    S: ViewState,
    VM: ViewModel<S>,
    Content: ViewContent
>: View where Content.State == S {
    @StateObject private var vm: VM
    @State private var isConfigured = false
    @Environment(\.dismiss) private var dismiss
    
    init(vm: VM) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    public static func make(vm: VM) -> some View {
        self.init(vm: vm)
    }
    
    public var body: some View {
        Content(state: $vm.state)
            .onAppear {
                if !isConfigured {
                    vm.configure()
                    isConfigured = true
                }
            }
            .onReceive(vm.dismissPublisher) {
                dismiss()
            }
            .preferredColorScheme(.light)
    }
}
