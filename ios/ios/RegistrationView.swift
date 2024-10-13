//
//  RegistrationView.swift
//  ios
//
//  Created by Yan on 19.09.2024.
//

import SwiftUI
import Foundation
import CryptoKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getUserJSONFilePath() -> URL {
    return getDocumentsDirectory().appendingPathComponent("users.json")
}

func hashPassword(_ password: String) -> String {
    let inputData = Data(password.utf8)
    let hashed = SHA256.hash(data: inputData)
    return hashed.compactMap { String(format: "%02x", $0) }.joined()
}

func saveUsersToFile(_ userList: UserList) {
    let fileURL = getUserJSONFilePath()

    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(userList)
        try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
        print("Users saved successfully to \(fileURL)")
    } catch {
        print("Failed to save users: \(error)")
    }
}

struct RegistrationView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var registrationMessage: String = ""
    
    var onRegisterSuccess: () -> Void
    @State private var userList: UserList? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            Button(action: {
                handleRegister()
            }) {
                Text("Register")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Text(registrationMessage)
                .foregroundColor(.red)
                .padding(.top, 10)
        }
        .padding()
        .onAppear(perform: loadUsers)
    }
    
    // MARK: - Load Users from JSON File
    func loadUsers() {
        let fileURL = getUserJSONFilePath()
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                userList = try decoder.decode(UserList.self, from: data)
            } catch {
                print("Error loading or decoding users from file: \(error)")
            }
        } else if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                userList = try decoder.decode(UserList.self, from: data)
            } catch {
                print("Error loading or decoding users from bundle: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
    
    // MARK: - Handle Registration Logic
    func handleRegister() {
        guard var users = userList?.users else {
            registrationMessage = "Error loading users."
            return
        }
        
        if users.contains(where: { $0.username == username }) {
            registrationMessage = "Username is already taken."
            return
        }
        

        if password != confirmPassword {
            registrationMessage = "Passwords do not match."
            return
        }
        
        let hashedPassword = hashPassword(password)
    
        let newUser = User(username: username, password: hashedPassword)
        users.append(newUser)
        
        userList?.users = users
        
        if let updatedUserList = userList {
            saveUsersToFile(updatedUserList)
        }
        
        registrationMessage = "Registration successful!"
        onRegisterSuccess()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView {
            // Do nothing
        }
    }
}
