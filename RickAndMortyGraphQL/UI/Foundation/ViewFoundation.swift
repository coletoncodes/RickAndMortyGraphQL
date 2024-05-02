//
//  ViewModel.swift
//
//
//  Created by Coleton Gorecke on 11/16/23.
//

import Foundation
import Combine
import SwiftUI

/// The ViewModel object to handle the business logic for a ``ViewStack``.
///
/// Should be subclassed by all ViewStack objects.
///
///
@MainActor open class ViewModel<State: ViewState>: ObservableObject {
    /// Set of Combine cancellables used to manage asynchronous tasks.
    public var cancellables = Set<AnyCancellable>()
    
    /// Published property representing the state of the ViewModel.
    @Published open var state = State()
    
    /// Initializes a new instance of this type.
    public required nonisolated init() {}
    
    /// Configures the ViewModel and handles giving the ``ViewState`` object the data it needs.
    /// Override this method to provide configuration logic.
    /// Default implementation is empty
    /// > Warning: This should be overriden and setup by subclasses.
    open func configureState() { }
    
    /// Dismisses the currently presented view, depending on where it's used.
    ///
    /// This fires a dismiss publisher that is connected to the ``ViewStack``.
    ///
    /// Should be used based on the information found [here](https://developer.apple.com/documentation/swiftui/environmentvalues/dismiss)
    ///
    /// It is also configurable to be overriden so you can have more fine grained control on what is dismissed based on your ``ViewState``'s needs.
    /// > Note: If using a ``Navigator`` for a NavigationStack, that mechanism is preferred for dismissal. Using this and an instance of a `Navigator` can cause undefined behavior.
    open func dismiss() {
        dismissSubject.send()
    }
    
    fileprivate var dismissPublisher: AnyPublisher<Void, Never> {
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
/// This object is responsible for giving a ``ViewContent`` the information (and data) it needs to draw itself.
///
/// It is highly configurable, but typically follows this standard
///
/// To use simply create 3 objects:
/// 1. A ViewState object.
///
/// This object has one simple protocol conformance. An empty initializer. By using structs (recommended), we get this init for free!
/// ```swift
/// struct SomeViewState: ViewState {
///     var someVar: SomeType
///     var send: (Action) -> Void = { _ in }
///     var someComputedVar: SomeType {
///        return someLogicToDetermineSomeType
///     }
///
///     enum Action {
///        case didPerformSomeAction
///     }
/// }
/// ```
/// > Note: For ``ViewState`` objects, some computed vars can be useful to avoid handling in your ViewModel, however they can be expensive and should be used for 'cheap' operations.
///
/// 2. A ``ViewModel`` subclass
///
/// ```swift
/// final class SomeViewModel: ViewModel<SomeViewState> {
///    // Add ViewModel dependencies, via Factory
///    @Injected(./someTypeDependency) private var someTypeDependency
///
///     override func configureState() {
///         state.someVar = someTypeDependency.varGetter
///         state.send = { [weak self] action in // to avoid cycle
///             switch action {
///                 case didPerformSomeAction:
///                     self?.performAction()
///             }
///         }
///      }
///
///     // Helpers
///     private func performAction() {
///       // some logic
///     }
/// }
/// ```
/// > Info: If a view model needs a dependency, or parameter, you can override the init, provide the super class init, and upon creation inject that dependency when called. Since the configureState() method is called onAppear, we do not want that to handle parameters, because we have limited control on when a SwiftUI view refreshes it's lifecycle. But by giving it into the initializer, we can decide how to scope our viewmodel's lifecycle across our entire application.
///
/// 3. Now we need a ViewContent object. This object represents must be a ``SwiftUI.View``
///
/// The configuration and onAppear is handled for us automatically since this will live inside a ``ViewStack`` object.
///
/// ```swift
/// struct SomeViewContent: ViewContent {
///     typealias State: SomeViewState
///     @Binding var state: State
///
///     var body: some View {
///        EmptyView()
///     }
/// }
/// ```
///
/// > Note: To ensure small views, we can pass the reference to the State down to other views, and get the natural benefits of SwiftUI.
///
/// ```swift
/// struct SomeSubView: View {
///     @Binding var state: SomeViewState
///
///     var body: some View {
///        Text(state.someValue)
///     }
/// }
///
/// ```
///
/// 4. Declare your ``ViewStack`` definition.
/// ```swift
///  typealias SomeViewStack = ViewStack<SomeViewState, SomeViewModel, SomeViewContent>
/// ```
///
/// 5. Call the ``ViewStack.make(vm: SomeViewModel()) -> some View`` method, where this ViewStack is needed.
///
/// **Previews:**
///
/// With previews, you have a few different options to render the stack.
///
/// ```swift
///  #Preview {
///     SomeViewContent(state: .constant(.init()) // or provide properties to the state.
///
///     // OR
///
///     // (Optional) subclass your ViewModel to provide a preview implementation instead.
///     SomeViewStack.make(vm: SomeViewModel())
///  }
/// ```
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
                    vm.configureState()
                    isConfigured = true
                }
            }
            .onReceive(vm.dismissPublisher) {
                dismiss()
            }
            .preferredColorScheme(.light)
    }
}
