//
//  GroceryListTableVC.swift
//  ShoppingList
//
//  Created by Daniel J Janiak on 10/7/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import UIKit
import CoreData


class GroceryListTableVC: UITableViewController {
    
    // MARK: - Properties 
    
    var shoppingItemsList = [ShoppingItem]()
    let REUSE_IDENTIFIER = "shoppingListItemCell"
    
    var managedObjectContext: NSManagedObjectContext?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.coreDataStack.persistentContainer.viewContext
        
        fetchData()
    }
    
    // MARK: - Actions

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Item for the Shopping List", message: "Add an item?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField() { textField in
            
        }
        
        /* Create the alert actions/ options for the user */
        let addItemAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { [weak self] (action: UIAlertAction) in
            
//            let alertControllerTextField = alertController.textFields?.first
//            
//            let entity = NSEntityDescription.entity(forEntityName: "ShoppingItem", in: (self?.managedObjectContext)!)
//            
//            let item = NSManagedObject(entity: entity!, insertInto: self?.managedObjectContext)
//            item.setValue(alertControllerTextField!.text!, forKey: "name")
            
            let itemNameString: String?
            
            if alertController.textFields?.first?.text != "" {
                itemNameString = alertController.textFields?.first?.text
            } else {
                return
            }
            
            let shoppingItemEntity = ShoppingItem(context: (self?.managedObjectContext)!)
            shoppingItemEntity.name = itemNameString
            
            /* Persist the data */
            do {
                
                try self?.managedObjectContext?.save()
                
            } catch {
                fatalError("Failed to persist new data")
            }
            
            self?.fetchData()
            
        }
        
        let cancelAcion = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(addItemAction)
        alertController.addAction(cancelAcion)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    func fetchData() {
        
        // let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "ShoppingItem")
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        
        /* Get the result of the fetch request */
        
        do {
            
            let fetchResults = try managedObjectContext?.fetch(fetchRequest)
            
            shoppingItemsList = fetchResults!
            
            tableView.reloadData()
            
        } catch {
            fatalError("Unable to fetch the shopping list items")
        }
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItemsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath)
        
        let shoppingItem = self.shoppingItemsList[indexPath.row]

        // cell.textLabel?.text = shoppingItem.value(forKey: "name") as? String
        cell.textLabel?.text = shoppingItem.name

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
