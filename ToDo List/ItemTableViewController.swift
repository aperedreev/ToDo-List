//
//  ItemTableViewController.swift
//  ToDo List
//
//  Created by Aleksey Peredreev on 10.09.2019.
//  Copyright © 2019 Aleksey Peredreev. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {

    var items = [Item]()
    
//    func loadSampleItems() {
//        items += [Item(name: "item1"), Item(name: "item2"), Item(name: "item 3")]
//    }
    
    class StorageManagerService {
        static let itemKey = "items"

        static func saveItems(items: [Item]?) {
            let defaults = UserDefaults.standard
            var list = [String]()
                for item in items! {
                    list.append(item.name)
                }
            defaults.set(list, forKey: itemKey)
        }
        static func loadItems() -> [Item]? {
            var list = [Item]()
            let defaults = UserDefaults.standard
            let listStrings = defaults.value(forKey: itemKey) as? [String]
            
            guard listStrings != nil else {
                return nil
            }
            for string in listStrings! {
                let item = Item(name: string)
                list.append(item)
            }
            return list
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loading sample items
        //loadSampleItems()
        
        //navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Load saved items
        if let savedItems = StorageManagerService.loadItems() {
            items += savedItems
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        // Configure the cell...
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name

        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        let srcViewCon = sender.source as? ViewController
        let item = srcViewCon?.item
        if (srcViewCon != nil && item?.name != ""){
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing item
                items[selectedIndexPath.row] = item!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
        // Add a new item
        let newIndexPath = NSIndexPath(row: items.count, section: 0)
            items.append(item!)
            tableView.insertRows(at: [newIndexPath as IndexPath], with: UITableView.RowAnimation.bottom)
            }
            StorageManagerService.saveItems(items: items)
        }
    }
    
//    func saveItems() {
//        do {
//            let isSaved = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
//            try isSaved.write(to: Item.ArchiveURL)
//        }
//        catch {
//            print("Failed to save items...")
//        }
//    }
//
//    func loadItems() -> [Item]? {
//        return try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
//        try isSaved.read(from: Item.ArchiveURL)
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            StorageManagerService.saveItems(items: items)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! ViewController
            // Get the cell that generated this segue
            if let selectedCell = sender as? ItemTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedItem = items[indexPath.row]
                detailVC.item = selectedItem
            }
        } else if segue.identifier == "AddItem" {
            
        }
    }
    

}
