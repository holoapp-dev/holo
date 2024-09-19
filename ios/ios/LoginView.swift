//
//  LoginView.swift
//  ios
//
//  Created by Yan on 18.09.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var isRegistering: Bool = false
    @State private var userList: UserList? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to HoloApp")
                    .font(.largeTitle)
                    .bold()
                    .fontWeight(.heavy)
                    .padding(EdgeInsets(top: 0,leading: 0, bottom: 75, trailing: 0))
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: {
                    handleLogin()
                }) {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                
                Text(loginMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
                
                NavigationLink(
                    destination: ContentView(),
                    isActive: $isLoggedIn,
                    label: {
                        EmptyView()
                    }
                )
                Button(action: {
                    isRegistering = true
                }) {
                    Text("Register")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                NavigationLink(
                    destination: RegistrationView(){
                        isRegistering = false
                    },
                    isActive: $isRegistering,
                    label: {
                        EmptyView()
                    }
                )
                
                
            }
            .padding()
            .onAppear(perform: loadUsers)
        }
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
                    print("Error loading users from file: \(error)")
                }
            } else if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    userList = try decoder.decode(UserList.self, from: data)
                } catch {
                    print("Error loading users from bundle: \(error)")
                }
            } else {
                print("JSON file not found.")
            }
        }

    // MARK: - Login Logic
    func handleLogin() {
        guard let users = userList?.users else {
            loginMessage = "No users available."
            return
        }
        
        if let matchingUser = users.first(where: { $0.username == username && $0.password == password }) {
            print("Logged in as \(matchingUser.username)")
            loginMessage = ""
            isLoggedIn = true
        } else {
            loginMessage = "Invalid username or password."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
