//
//  TeamStatsTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/30/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class TeamStatsTableViewController: UITableViewController {
    
    @IBOutlet var statTable: UITableView!
    
    var ids:[Int64]?
    var elementDmg = [0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Total Damage Per Color"
        
        
        calcStats()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        statTable.reloadData()
    }
    
    private func calcStats() {
        
        var mnstrs:[Monster] = []
        
        for id in ids! {
            let idINT = Int(id)
            mnstrs.append(getMonster(id: idINT))
        }
        
        for mnstr in mnstrs {
            
            let element = mnstr.element!
            var element2:Int
            
            if mnstr.element2 != nil {
                element2 = mnstr.element2!
            }
            else {
                element2 = -1
            }
            
            let atk = mnstr.atk_max!
            let atksub = atk/10
            let atksubdiff = atksub*3
            
            if element == 0 {
                elementDmg[0] += atk
            }
            else if element == 1 {
                elementDmg[1] += atk
            }
            else if element == 2 {
                elementDmg[2] += atk
            }
            else if element == 3 {
                elementDmg[3] += atk
            }
            else if element == 4{
                elementDmg[4] += atk
            }
            
            
            if element2 == 0 {
                if element2 == element {
                    elementDmg[0] += atksub
                }
                else {
                    elementDmg[0] += atksubdiff
                }
            }
            
            else if element2 == 1 {
                if element2 == element {
                    elementDmg[1] += atksub
                }
                else {
                    elementDmg[1] += atksubdiff
                }            }
            else if element2 == 2 {
                if element2 == element {
                    elementDmg[2] += atksub
                }
                else {
                    elementDmg[3] += atksubdiff
                }
                
            }
            else if element2 == 3 {
                if element2 == element {
                    elementDmg[3] += atksub
                }
                else {
                    elementDmg[3] += atksubdiff
                }
                
            }
            else if element2 == 4 {
                if element2 == element {
                    elementDmg[4] += atksub
                }
                else {
                    elementDmg[4] += atksubdiff
                }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elementDmg.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statcell", for: indexPath)
        let index = indexPath.row
        
        let dmg = elementDmg[index]
        
        if index == 0 {
            cell.textLabel?.text = "Red Damage"
        }
        else if index == 1 {
            cell.textLabel?.text = "Blue Damage"
        }
        else if index == 2{
            cell.textLabel?.text = "Green Damage"
        }
        else if index == 3 {
            cell.textLabel?.text = "Light Damage"
        }
        else if index == 4 {
            cell.textLabel?.text = "Dark Damage"
        }
        cell.detailTextLabel?.text = String(dmg)
        // Configure the cell...

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
