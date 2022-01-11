//
//  GameViewController.swift
//  FindNumber
//
//  Created by admin1 on 27.12.2021.

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var newGameButton: UIButton!
    lazy var game = Game(countItems: buttons.count) { [weak self] (status, time) in
        //?
        
        guard let self = self else {return}
        
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    //метод когда пользователь выходит из активити (игры)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    private func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal) //сменили цифры на кнопки
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
            
            
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status {
            
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
            
            
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
            newGameButton.isHidden = false
            if game.isNewRecord{
                showAlert()
            } else {
               showAlertActionSheet()
            }
            
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            showAlertActionSheet()
        }
    }
    
    //Создаем алерт
    private func showAlert(){
        
        let alert = UIAlertController(title: "Поздравляем!", message: "Вы установили новый рекорд!", preferredStyle: .alert)
        //Создаем кнопку, чтобы пользователь мог закрыть алерт
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        //ниже функция показа
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertActionSheet(){
        let alert = UIAlertController(title: "Что Вы хотите сделать далее?", message: nil, preferredStyle: .actionSheet)
        //кнопка начала новой игры
        let newGameAction = UIAlertAction(title: "Начать новую игру", style: .default) { [weak self] (_) in
            self?.game.newGame()
            self?.setupScreen()
        }
        //кнопка показать рекорд
        let showRecord = UIAlertAction(title: "Посмотреть рекорд", style: .default) { [weak self] (_) in
            
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
    }
        //кнопка перейти в меню
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive) { [weak self] (_) in
            self?.navigationController?.popViewController(animated: true)
        }
        //кнопка выхода
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    
        //добавляем эти кнопки к алерту
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        //прописываем возможность показа алерта для айпеда
        if let popover = alert.popoverPresentationController{
            popover.sourceView = statusLabel
        }
        
        present(alert, animated: true, completion: nil)
}
}
