//
//  TabBarControllerViewController.swift
//  Mitali_Assignment2
//
//  Created by Siddharth Trivedi on 2024-11-18.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                let editVC = EditViewController()
                let historyVC = HistoryViewController()
                
                // Set titles for the tabs
        editVC.tabBarItem = UITabBarItem(title: "Edit", image: nil, tag: 0)
        historyVC.tabBarItem = UITabBarItem(title: "History", image:nil,tag: 1)
                
                // Embed in navigation controllers for better navigation behavior
                let editNav = UINavigationController(rootViewController: editVC)
                let historyNav = UINavigationController(rootViewController: historyVC)
                
                // Set the view controllers for the TabBarController
                viewControllers = [editNav, historyNav]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
