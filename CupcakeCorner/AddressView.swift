//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

struct AddressView: View {
    @StateObject var order: Order
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
