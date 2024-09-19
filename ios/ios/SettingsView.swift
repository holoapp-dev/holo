//
//  SettingsView.swift
//  ios
//
//  Created by Yan on 18.09.2024.
//

import SwiftUI

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
