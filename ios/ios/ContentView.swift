import SwiftUI

internal struct Task: Identifiable {
    internal let id = UUID()
    internal let title: String
    internal var isCompleted: Bool
}

struct ContentView: View {
    var body: some View {
        TabView {
            ChecklistView()
                .tabItem {
                    Label("Tab 1", systemImage: "1.square.fill")
                }
            
            ChecklistView()
                .tabItem {
                    Label("Tab 2", systemImage: "2.square.fill")
                }
            
            ChecklistView()
                .tabItem {
                    Label("Tab 3", systemImage: "3.square.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
