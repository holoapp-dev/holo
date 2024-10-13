//
//  ThemeManager.swift
//  ios
//
//  Created by Yan on 20.09.2024.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        if UserDefaults.standard.object(forKey: "isDarkMode") != nil {
            self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        }
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}
