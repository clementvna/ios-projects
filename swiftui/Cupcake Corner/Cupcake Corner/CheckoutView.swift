//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Clément Villanueva on 14/11/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingProblem = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.data.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("There was a problem.", isPresented: $showingProblem) {
            Button("OK") {}
        } message: {
            Text("Please check your internet connection.")
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(OrderData.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(OrderData.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            showingProblem = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
