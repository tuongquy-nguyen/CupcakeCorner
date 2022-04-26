//
//  Order.swift
//  CupcakeCorner
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

class Order: ObservableObject {
    
    
    static let types = ["Vanilla", "Strawberry", "Rainbow", "Chocolate", "Matcha"]
    
    @Published var quantity = 3
    @Published var type = 0
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkle = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkle = false
}
