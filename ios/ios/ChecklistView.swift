//
//  ChecklistView.swift
//  ios
//
//  Created by Yan on 18.09.2024.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}

struct ChecklistView: View {
    @State private var products: [Product] = [
        Product(name: "Apple"),
        Product(name: "Milk"),
        Product(name: "Bread")
    ]
    

    @State private var newProductName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add new product", text: $newProductName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        addNewProduct()
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Circle().fill(Color.blue))
                            .foregroundColor(.white)
                    }
                    .disabled(newProductName.isEmpty)
                }
                
                List {
                    ForEach($products) { $product in
                        HStack {
                            Button(action: {
                                product.isChecked.toggle()
                            }) {
                                Image(systemName: product.isChecked ? "checkmark.square" : "square")
                                    .foregroundColor(product.isChecked ? .green : .gray)
                            }
                            
                            if #available(iOS 16.0, *) {
                                TextField("Product name", text: $product.name)
                                    .strikethrough(product.isChecked)
                                    .foregroundColor(product.isChecked ? .gray : .black)
                            } else {
                            }
                        }
                    }
                    .onDelete(perform: deleteProduct)
                    .onMove(perform: moveProduct)
                }
                .navigationBarTitle("Products")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: {
                        addNewProduct()
                    }) {
                        Image(systemName: "plus")
                    }
                )
            }
        }
    }
    
    private func addNewProduct() {
        let newProduct = Product(name: newProductName)
        products.append(newProduct)
        newProductName = ""
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
    
    private func moveProduct(from source: IndexSet, to destination: Int) {
        products.move(fromOffsets: source, toOffset: destination)
    }
}
