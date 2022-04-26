//
//  Order.swift
//  CupcakeCorner
//
//  Created by KET on 26/04/2022.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkle, name, streetAddress, city, zip, cost
    }
    
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
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Int {
//        7000 vnd per cake
        var cost = quantity * 7000
//        complicated cost more
        cost += type != 0 ? quantity * 500 : 0
//        3000 per cake if add extra frosting
        if extraFrosting {
            cost += quantity * 3000
        }
        if addSprinkle {
            cost += quantity * 1000
        }
            
        return cost
    }
    
//    encode method to make this class conform to codable protocol
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkle, forKey: .addSprinkle)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
        try container.encode(cost, forKey: .cost)
    }
    
//    required init
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkle = try container.decode(Bool.self, forKey: .addSprinkle)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {
//        basic init
    }
}
