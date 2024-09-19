//
//  RegistrationView.swift
//  ios
//
//  Created by Yan on 19.09.2024.
//

import SwiftUI
import Foundation

// Helper function to get the URL of the users.json file in the Documents Directory
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getUserJSONFilePath() -> URL {
    return getDocumentsDirectory().appendingPathComponent("users.json")
}

// Function to save user data back to the Documents Directory
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

// Define User model matching JSON structure
struct RegistrationView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var registrationMessage: String = ""
    
    var onRegisterSuccess: () -> Void
    @State private var userList: UserList? = nil // Holds decoded user data
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Register")
                .font(.largeTitle)
                .bold()
            
            // Username field
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .autocapitalization(.none)
            
            // Password field
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            // Confirm Password field
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            // Register button
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
            
            // Show registration message if needed
            Text(registrationMessage)
                .foregroundColor(.red)
                .padding(.top, 10)
        }
        .padding()
        .onAppear(perform: loadUsers) // Load existing users when view appears
    }
    
    // MARK: - Load Users from JSON File
    func loadUsers() {
        let fileURL = getUserJSONFilePath()
        
        // Try to load users from the Documents Directory first
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                userList = try decoder.decode(UserList.self, from: data)
            } catch {
                print("Error loading or decoding users from file: \(error)")
            }
        } else if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
            // If the file doesn't exist, load it from the bundle (read-only)
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
            
            // Check if username is already taken
            if users.contains(where: { $0.username == username }) {
                registrationMessage = "Username is already taken."
                return
            }
            
            // Check if passwords match
            if password != confirmPassword {
                registrationMessage = "Passwords do not match."
                return
            }
            
            // Add the new user to the mutable copy of users
            let newUser = User(username: username, password: password)
            users.append(newUser) // Now this works as `users` is mutable
            
            // Update the userList with the modified users array
            userList?.users = users
            
            // Save the updated users to file
            if let updatedUserList = userList {
                saveUsersToFile(updatedUserList)
            }
            
            registrationMessage = "Registration successful!"
            onRegisterSuccess() // Call the callback to return to login
        }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView {
            // Do nothing
        }
    }
}
