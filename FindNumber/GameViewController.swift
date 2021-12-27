//
//  GameViewController.swift
//  FindNumber
//
//  Created by admin1 on 27.12.2021.

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pressButton(_ sender: UIButton) {
        sender.isHidden = true
        print(sender.currentTitle)
    }
}
