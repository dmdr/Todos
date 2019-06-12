//
//  ViewController.swift
//  Todos
//
//  Created by Daniel Drennan on 10/06/2019.
//  Copyright © 2019 Daniel Drennan. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
  
//  var itemArray = ["Find Bo", "Buy Macbook pro", "Each healthy"]
  var itemArray = [Item]()

  // UserData step:1
  //let defaults = UserDefaults.standard

  // NSCoder step:1
  let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // debug show path where our plist file wil go
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    //print( dataFilePath )
    
    // UserData/NSCoder step:3
//if let itemArrayValue = defaults.array(forKey: "TodoListArray") as? [Item] {
 //     itemArray = itemArrayValue
  // }

    loadItems();

    // only for custom cells
   // self.tableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoItemCell")
    

  }
  
  // MARK - Tableview Datasource Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemArray.count
  }
  

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) //as! CustomMessageCell

    let item = itemArray[indexPath.row]
    cell.textLabel?.text = item.sTitle
    cell.accessoryType = item.bDone ? .checkmark : .none

    return cell
  }
  
  //MARK - TableView Delegate Methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print( "didSelectRowAt \(itemArray[indexPath.row])")
    
    itemArray[indexPath.row].bDone = !itemArray[indexPath.row].bDone
    saveDataToDevice()
    
    // multiple check allowed
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
  
  
  //MARK - Add New Items
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
    
    let actionAdd = UIAlertAction(title: "Add Item", style: .default) { (action) in
      if textField.text!.count > 0 {
        let newItem = Item()
        newItem.sTitle = textField.text!
        newItem.bDone = false
        self.itemArray.append( newItem )
        self.saveDataToDevice()
      }
    }
    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addTextField { (alerttextField) in
      alerttextField.placeholder = "Create new item"
      textField = alerttextField // using the object here .text not be set as this is executed when the [+] is clicked
                                 // the action closure above is called when the button i clicked

    }
    alert.addAction(actionAdd)
    alert.addAction(actionCancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  //
  func saveDataToDevice() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode( itemArray )
      try data.write(to: dataFilePath!)
    } catch {
      print("Error encoding item array, \(error)")
    }
    
    self.tableView.reloadData()
  }
 
  //
  func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath! ) {
      let decoder = PropertyListDecoder()
      do {
        itemArray = try decoder.decode([Item].self, from: data)
      } catch {
        print("Error decoding data, \(error)")
      }
    }
   // self.tableView.reloadData()
  }

}

