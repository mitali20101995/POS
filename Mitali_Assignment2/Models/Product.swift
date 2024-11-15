//
//  Product.swift
//  Mitali_Assignment2
//
//  Created by Mitali Ahir on 2024-11-15.
//

struct Product{
    
    let name: String
    let price: Double
    let quantity: Int
    
    func totalPrice() -> Double{
        return price * Double(quantity)
    }
}
var sampleProducts: [Product] = [Product(name: "Computers", price: 3000.67, quantity: 32), Product(name: "Mobile Phones", price:1777.67, quantity: 12), Product(name: "Laptops", price: 5000.67, quantity:20)]
