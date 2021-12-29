//
//  YellowViewController.swift
//  FindNumber
//
//  Created by admin1 on 28.12.2021.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goToBlueController(_ sender: Any) {
        performSegue(withIdentifier: "goToBlue", sender: nil)
    }
}
