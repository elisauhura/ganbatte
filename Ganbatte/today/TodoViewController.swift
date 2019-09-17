//
//  TodoViewController.swift
//  Ganbatte
//
//  Created by Student on 13/09/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    var activities = [
        "Limpar a casa",
        "Fazer a tarefa"
    ]
    
    func addActivity(_ activity: String) {
        if activities.contains(activity) {
            let alert = UIAlertController(title: "Error", message: "You have already added this activity.", preferredStyle: .alert)
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                )
            )
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        
        } else {
            activities.append(activity)
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activities.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)

        // Configure the cell...

        if let todoCell = cell as? TodoViewCell {
            if indexPath.row == activities.count {
                todoCell.activityLabel.text = "Add to do..."
                todoCell.activityLabel.textColor = view.tintColor
            } else {
                todoCell.activityLabel.text = activities[indexPath.row]
                todoCell.activityLabel.textColor = .black
            }
        }
            
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == activities.count {
            //1. Create the alert controller.
            let alert = UIAlertController(title: "Add a new task", message: "type the name of your task", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.placeholder = "Task name here..."
            }
            
            alert.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .default,
                    handler: nil
                )
            )
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {
                        [weak alert] (_) in
                            let text = alert?.textFields!.first?.text ?? ""
                            if text != "" {
                                self.addActivity(text)
                            }
                    }
                )
            )
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if indexPath.row == activities.count { return false }
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            activities.remove(at: indexPath.row)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
