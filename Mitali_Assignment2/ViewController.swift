//
//  ViewController.swift
//  Mitali_Assignment2
//
//  Created by Mitali Ahir on 2024-11-15.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var sampleProducts: [Product] = [Product(name: "Cameras", price: 3000.67, quantity: 32), Product(name: "Mobile Phones", price:1777.67, quantity: 12), Product(name: "Laptops", price: 5000.67, quantity:20), Product(name: "Tablets", price: 500.67, quantity: 23)]
    
    @IBOutlet weak var productCatalogPickerView: UIPickerView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var currentSelectionLabel: UILabel!
    @IBOutlet weak var userIntendedQtyLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    @IBAction func managerView() {
        let alert = UIAlertController(title: "Enter Code", message: nil, preferredStyle: .alert)
        // Add the text field to the alert
        alert.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password" }
        // Get the entered password from the text field
        if let enteredPassword = alert.textFields?.first?.text {
             let password = "1234"
             if enteredPassword == password {
//                let managerVC = storyboard?.instantiateViewController(withIdentifier: "ManagerViewController")
//                present(managerVC!, animated: true, completion: nil)
            }
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productCatalogPickerView.dataSource = self
        productCatalogPickerView.delegate = self
        buyButton.isEnabled = false
        
    }
    func updateTotalValue() {
        if let userIntendedQty = Int(userIntendedQtyLabel.text!) {
            totalPriceLabel.text = "$" +  String(sampleProducts[productCatalogPickerView.selectedRow(inComponent: 0)].totalPrice(desiredQTY: userIntendedQty))
        }
    }
    
    func preventInvalidTransaction() {
        if let userIntendedQty = Int(userIntendedQtyLabel.text!) {
            if sampleProducts[productCatalogPickerView.selectedRow(inComponent: 0)].isAvailable(desiredQTY: userIntendedQty){
                  buyButton.isEnabled = true
                  totalPriceLabel.textColor = .black
            }else {
                buyButton.isEnabled = false
                totalPriceLabel.textColor = .red
            }
        }
    }

    @IBAction func digitPressed(_ sender: UIButton) {
        if(userIntendedQtyLabel.text?.isEmpty == false){
            userIntendedQtyLabel.text?.append((sender.titleLabel?.text)!)
        }else{
            userIntendedQtyLabel.text = sender.titleLabel?.text
        }
        updateTotalValue()
        preventInvalidTransaction()
        
    }
    
    
    @IBAction func clearDesiredQtySelection() {
        userIntendedQtyLabel.text?.removeAll()
        totalPriceLabel.text?.removeAll()
        preventInvalidTransaction()
        productCatalogPickerView.reloadAllComponents()
        buyButton.isEnabled = false
    }
    
    
    @IBAction func removeLastSelectedDigit() {
        if((userIntendedQtyLabel.text?.isEmpty == false)){
             userIntendedQtyLabel.text?.removeLast()
        }
        updateTotalValue()
        preventInvalidTransaction()
    }
    
    
    @IBAction func checkout() {
        let alert = UIAlertController(title: "Transaction Successful", message: "Your transaction has been completed successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        if let userIntendedQty = Int(userIntendedQtyLabel.text!) {
            sampleProducts[productCatalogPickerView.selectedRow(inComponent: 0)].updateQTY(desiredQTY: userIntendedQty)
        }
        userIntendedQtyLabel.text?.removeAll()
        totalPriceLabel.text?.removeAll()
        productCatalogPickerView.reloadAllComponents()
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sampleProducts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sampleProducts[row].name + " \(sampleProducts[row].quantity)" + "$ \(sampleProducts[row].price)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectionLabel.text = sampleProducts[row].name
        preventInvalidTransaction()
        productCatalogPickerView.reloadAllComponents()
        
    }


}

