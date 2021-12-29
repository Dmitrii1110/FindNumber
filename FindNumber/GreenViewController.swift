//
//  GreenViewController.swift
//  FindNumber
//
//  Created by admin1 on 29.12.2021.
//

import UIKit

class GreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func goToRoot(_ sender: Any) {
        //self.navigationController?.popToRootViewController(animated: true)
        
        if let viewControllers = self.navigationController?.viewControllers{
            for vc in viewControllers{
                if vc is YellowViewController{
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
    }
    
}
