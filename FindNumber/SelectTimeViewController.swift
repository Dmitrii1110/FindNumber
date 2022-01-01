//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by admin1 on 29.12.2021.
//

import UIKit

class SelectTimeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView?.dataSource = self
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    }
            
            
            

extension SelectTimeViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        
        cell.textLabel?.text = "section - \(indexPath.section) row - \(indexPath.row)"
        
        return cell
    }
    
    
}
