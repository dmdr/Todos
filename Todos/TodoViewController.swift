//
//  ViewController.swift
//  Todos
//
//  Created by Daniel Drennan on 10/06/2019.
//  Copyright © 2019 Daniel Drennan. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

  let itemArray = ["Find Bo", "Buy Macbook pro", "Each healthy"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
// only for custom cells
   // self.tableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoItemCell")
    
  }
  
  
  // MARK - Tableview Datasource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //as! CustomMessageCell

    cell.textLabel?.text = itemArray[indexPath.row]

    return cell
  }
  
  //MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print( "didSelectRowAt \(itemArray[indexPath.row])")
    
   // removeAllCheckMarks()
    // multiple check allowed
    tableView.cellForRow(at: indexPath)?.accessoryType = ( tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ) ? .none : .checkmark
    tableView.deselectRow(at: indexPath, animated: true)
  }

  // remove all checkmarks
  /*
  func removeAllCheckMarks() {
    for x in 0...itemArray.count {
      let xx : IndexPath = IndexPath(item: x, section: 0)
      tableView.cellForRow(at: xx)?.accessoryType = .none
    }
  }
   */
}
