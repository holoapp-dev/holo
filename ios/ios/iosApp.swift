import SwiftUI

@main
struct MyApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(themeManager)
                .environmentObject(userSession)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    
}

