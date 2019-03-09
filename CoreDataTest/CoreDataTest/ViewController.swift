//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Jun Ishii on 2019/03/09.
//  Copyright © 2019年 Jun Ishii. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var monsters:[Monster] = []
    
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Monster")
        do{
            monsters = try self.managedObjectContext.fetch(request) as! [Monster]
        }catch{
            print("error")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let monster = Monster(context: self.managedObjectContext)
        monster.name = textField.text
        self.monsters.append(monster)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        tableView.reloadData()
        
        textField.text = ""
        
        return true
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let monster = monsters[indexPath.row]
        cell.textLabel?.text = monster.name
        return cell
    }
}

