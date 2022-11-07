//
//  iqueApp.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import SwiftUIRouter
import Sentry

extension View {
    func navigationTransition() -> some View {
        modifier(NavigationTransition())
    }
}

private struct NavigationTransition: ViewModifier {
    @EnvironmentObject private var navigator: Navigator
    
    private func transition(for direction: NavigationAction.Direction?) -> AnyTransition {
        if direction == .deeper || direction == .sideways {
            return AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
        }
        else {
            return AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .animation(.easeInOut, value: navigator.path)
            .transition(transition(for: navigator.lastAction?.direction))
    }
}


struct RootView: View {
    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        VStack {
            RootRoutes()
        }
        /// To better keep track of the current path we'll print it to the console every time it changes.
        /// This would also be a great time to store the current path to UserDefaults/AppStorage, or send it to a
        /// backend for analytic reasons.
        .onChange(of: navigator.path) { newPath in
            print("Current path:", newPath)
        }
    }

}

private struct RootRoutes: View {
    var body: some View {
        SwitchRoutes {
            Route("/", content: MainView())
            
            Route("auth", content: WelcomeView())
            
            Route("tickets", content: TicketsView())
                        
            Route("tickets/:id") { info in
                TicketDetailView(ticketId: info.parameters["id"]!)
            }
            
            Route("stores/:id") { info in
                StoreDetailView(storeId: info.parameters["id"]!)
            }
            
            Route {
                Navigate(to: "/auth", replace: true)
            }
            
        }
        .navigationTransition()
    }
}

@main
struct iqueApp: App {

    var body: some Scene {
        WindowGroup {
            Router {
                RootView()
            }
        }
    }
}
