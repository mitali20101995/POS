//
//  ViewController.swift
//  Mitali_Assignment2
//
//  Created by Mitali Ahir on 2024-11-15.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var sampleProducts: [Product] = [Product(name: "Cameras", price: 3000.67, quantity: 32), Product(name: "Phones", price:1777.67, quantity: 12), Product(name: "Laptops", price: 5000.67, quantity:20), Product(name: "Tablets", price: 500.67, quantity: 23)]
    
    @IBOutlet weak var productCatalogPickerView: UIPickerView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var currentSelectionLabel: UILabel!
    @IBOutlet weak var userIntendedQtyLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    
    //asking for manager credentials to transit to manager view through alertController
    @IBAction func managerView() {
        let password = "1234"
        let alert = UIAlertController(title: "Enter Code", message: nil, preferredStyle: .alert)
        // Add the text field to the alert
        alert.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password" }
        // Get the entered password from the text field
        if let enteredPassword = alert.textFields?.first?.text {
             if enteredPassword == password {
                 //navigate to managerview TabBarViewController
                 performSegue(withIdentifier: "managerViewTransition", sender: self)
                 print("Correct Password")
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
    
    //update total value label with user selected input
    func updateTotalValue() {
        if let userIntendedQty = Int(userIntendedQtyLabel.text!) {
            totalPriceLabel.text = "$" +  String(sampleProducts[productCatalogPickerView.selectedRow(inComponent: 0)].totalPrice(desiredQTY: userIntendedQty))
        }
    }
    
    //disable the Buy button in case of invalid user selection and show total price in red to indicate that to user
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

    //capture desiresd Quantity
    @IBAction func digitPressed(_ sender: UIButton) {
        if(userIntendedQtyLabel.text?.isEmpty == false){
            userIntendedQtyLabel.text?.append((sender.titleLabel?.text)!)
        }else{
            userIntendedQtyLabel.text = sender.titleLabel?.text
        }
        updateTotalValue()
        preventInvalidTransaction()
        
    }
    
    //clear desired Quantity when 'C' selected
    @IBAction func clearDesiredQtySelection() {
        userIntendedQtyLabel.text?.removeAll()
        totalPriceLabel.text?.removeAll()
        preventInvalidTransaction()
        productCatalogPickerView.reloadAllComponents()
        buyButton.isEnabled = false
    }
    
    //remove last digit from selection
    @IBAction func removeLastSelectedDigit() {
        if((userIntendedQtyLabel.text?.isEmpty == false)){
             userIntendedQtyLabel.text?.removeLast()
        }
        updateTotalValue()
        preventInvalidTransaction()
    }
    
    //when user is ready and with valid user selection show successful transaction message and update product quantity, reset all selection to reflact the change
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
    
    //no of column for product pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //no of rows for pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sampleProducts.count
    }
    
    //title or content for each row in pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sampleProducts[row].name + "     \(sampleProducts[row].quantity)" + "    $\(sampleProducts[row].price)"
    }
    
    //when row is selected we want to update current selection to showcase
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectionLabel.text = sampleProducts[row].name
        preventInvalidTransaction()
        productCatalogPickerView.reloadAllComponents()
        
    }
    

    
}

