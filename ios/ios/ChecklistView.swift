//
//  ChecklistView.swift
//  ios
//
//  Created by Yan on 18.09.2024.
//

import SwiftUI

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
