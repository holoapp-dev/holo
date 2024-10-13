//
//  UserSession.swift
//  ios
//
//  Created by Yan on 21.09.2024.
//

import SwiftUI
import Foundation

class UserSession: ObservableObject {
    @Published var currentUser: User?
    
    func userTaker(username: String, password: String) {
            self.currentUser = User(username: username, password: password)
        }
        
        func logout() {
            self.currentUser = nil
        }
}
