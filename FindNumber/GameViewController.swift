//
//  GameViewController.swift
//  FindNumber
//
//  Created by admin1 on 27.12.2021.

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    lazy var game = Game(countItems: buttons.count)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    private func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal) //сменили цифры на кнопки
            buttons[index].isHidden = false //чтобы все кнопки были видны
            
            
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.title
        
        if game.status == .win{
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
        }
    }
    
}
