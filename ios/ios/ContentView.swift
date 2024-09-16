import SwiftUI

internal struct Task: Identifiable {
    internal let id = UUID()
    internal let title: String
    internal var isCompleted: Bool
}

struct ChecklistView: View {
    @State private var tasks: [Task] = [
        Task(title: "Task 1", isCompleted: false),
        Task(title: "Task 2", isCompleted: false),
        Task(title: "Task 3", isCompleted: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($tasks) { $task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        Button(action: {
                            task.isCompleted.toggle()
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Checklist")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack{
            Menu {
                Button("White") {
                    print("White")
                }
                Button("Black"){
                    print("Black")
                }
            }
        label: {
                Text("Themes")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
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
