//
//  TeamListTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/10/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class TeamListTableViewController: UITableViewController {
    
    @IBOutlet var teamlistview: UITableView!
    // An array of Teams
    // Each entry is a team object with attributes for the id's of the monsters on the team
    
    var teams: [NSManagedObject] = []
    
    var base_img_url = "https://www.padherder.com"

    
    // INFO ABOUT TEAM ENTITY:
    // Just holds the monster ID number to pull from monster array
    // The attribute monster1 is used for both own and friend leaders


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        deleteAllRecords()

        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do {
            teams = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print ("Failed to retrieve teams", err)
        }
        
        
        if (teams.count == 0) {
            print ("There are no teams")
        }
        else {
            print ("There are \(teams.count) teams")
        }
        
    }

    func addNewTeam() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(0, forKey: "monster1")
        item.setValue(0, forKey: "monster2")
        item.setValue(0, forKey: "monster3")
        item.setValue(0, forKey: "monster4")
        item.setValue(0, forKey: "monster5")
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save Team.", err)
        }
    }
    
    
    func addDefaultTeam() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(1, forKey: "monster1")
        item.setValue(4, forKey: "monster2")
        item.setValue(7, forKey: "monster3")
        item.setValue(10, forKey: "monster4")
        item.setValue(13, forKey: "monster5")
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save Team.", err)
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
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath) as! TeamCell
        
        if (teams.count != 0) {
            var monsters = (self.tabBarController?.viewControllers?.first as! MonsterDatabaseTableViewController).api_monster_list
            
            let team = teams[indexPath.row] as! Team
            let id = Int(team.monster1)
            
            print (monsters.count)
            
            let m_1 = monsters[id]
            
            let img_url = base_img_url + m_1.image40_href!
            cell.m1.setImageFromURl(stringImageUrl: img_url)
        }

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
    
    @IBAction func add_new_team(_ sender: Any) {
        addDefaultTeam()
    }
    

}