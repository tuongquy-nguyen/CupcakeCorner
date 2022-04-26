//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var showingConfirm = false
    @State private var confirmationMessage = ""
    
    @StateObject var order: Order
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
                
                Text("Your total is \(order.cost, format: .currency(code: "VND"))")
                    .font(.title.bold())
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .alert("Thank you!", isPresented: $showingConfirm) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async {
//        Encode the order after user press place
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
//        prepare the URL request to send data to the server
        let url = URL(string: "Https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
//        send order data
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedResult = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedResult.quantity)x \(Order.types[decodedResult.type]) cupcakes is on its way!"
            showingConfirm = true
        } catch {
            print("Check out failed!")
        }
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
