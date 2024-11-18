//
//  Product.swift
//  Mitali_Assignment2
//
//  Created by Mitali Ahir on 2024-11-15.
//

struct Product{
    
    let name: String
    let price: Double
    var quantity: Int
    
    //calculate total price when user indicates desired quantity for a product
    func totalPrice(desiredQTY: Int) -> Double{
        return price * Double(desiredQTY)
    }
    
    func isAvailable(desiredQTY: Int) -> Bool{
        return quantity >= desiredQTY && desiredQTY > 0
    }
    
    //update the quantity of product to showcase the change when user bought desired qty of that product
    mutating func updateQTY(desiredQTY: Int){
        quantity -= desiredQTY
    }
    
}
