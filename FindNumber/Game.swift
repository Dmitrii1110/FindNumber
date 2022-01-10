//
//  Game.swift
//  FindNumber
//
//  Created by admin1 on 27.12.2021.
//

import Foundation
import UIKit
//import XCTest

//прописываем
enum StatusGame{
    case start
    case win
    case lose
}

class Game{
    
    struct Item{
        var title:String
        var isFound:Bool = false
        var isError = false
    }
    
    private let data = Array(1...99)
    
    var items:[Item] = []
    
    private var countItems:Int
    
    var nextItem: Item?
    
    var status:StatusGame = .start{
        didSet{
            if status != .start{
                stopGame()
            }
        }
    }
    
    private var timeForGame:Int
    
    private var secondsGame:Int{
        didSet{
            if secondsGame == 0{
                status = .lose
            }
            updateTimer(status,secondsGame)
        }
    }
    
    private var timer:Timer?
    private var updateTimer:((StatusGame, Int)->Void)
    
    init(countItems:Int, updateTimer:@escaping (_ status:StatusGame,_ seconds:Int)->Void){
        self.countItems = countItems
        self.timeForGame = Settings.shared.currentSettings.timeForGame
        self.secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame(){
        var digits = data.shuffled() //перемешиваем массив
        
        items.removeAll()
        
        while items.count < countItems{
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
            
        }
        
        nextItem = items.shuffled().first //чтобы рандомно брать цифру
        
        updateTimer(status,timeForGame) //?
        
        if Settings.shared.currentSettings.timerState{
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block:{ [weak self] (_) in self?.secondsGame -= 1
    })
        }
        
    }
    
    func newGame(){
        status = .start
        setupGame()
        self.secondsGame = self.timeForGame
        
    }
    
    func check(index:Int){
        guard status == .start else {return}
        if items[index].title == nextItem?.title{
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(item) -> Bool in
                item.isFound == false
        })
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil{
            status = .win
        }
    }
    
    func stopGame(){
        timer?.invalidate()
    }
    
}
    
    
    extension Int{
        func secondsToString()->String{
            let minutes = self / 60
            let seconds = self % 60
            
            return String(format: "%d:%02d", minutes, seconds)
        
    }
    
}
