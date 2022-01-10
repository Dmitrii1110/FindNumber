//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by admin1 on 29.12.2021.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    var data:[Int] = [] //создан массив

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView?.dataSource = self
            tableView?.delegate = self //позволяет нам отслеживать все действия в таблице
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    }
            
extension SelectTimeViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count // считаем сколько элементов и столько строчек создаём
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row]) //вытаскиваем каждый элемент по индексу
        
        return cell
    }
    
    //Ниже функция для того чтобы выбранная строка из серой в белую перешла
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        //navigationController?.popToViewController(animated: true
        _ = navigationController?.popViewController(animated: true)
}
}

        
        
        
        
    //func deselectRow(at indexPath: IndexPath,
           // animated: Bool)
        
        //Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        //navigationController?.popToViewController(animated: true)
        //print(data[indexPath.row])
    
    
//}
