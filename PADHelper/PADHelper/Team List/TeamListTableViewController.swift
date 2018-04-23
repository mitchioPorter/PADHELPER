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
        
        deleteAllRecords()
//        addDefaultTeam()
        

        self.teamlistview.rowHeight = 100
        self.teamlistview.reloadData()

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
        
        teamlistview.reloadData()
        
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
        item.setValue(5, forKey: "monster2")
        item.setValue(8, forKey: "monster3")
        item.setValue(11, forKey: "monster4")
        item.setValue(14, forKey: "monster5")
        item.setValue(1, forKey: "monster6")
        item.setValue("Default Team", forKey: "name")

        
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save Team.", err)
        }
        teamlistview.reloadData()
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
            var monsters = api_monster_list
            
            let team = teams[indexPath.row] as! Team
            let id = Int(team.monster1)
            let m_1 = monsters[id]
            
            let id2 = Int(team.monster2)
            let m_2 = monsters[id2]

            let id3 = Int(team.monster3)
            let m_3 = monsters[id3]

            let id4 = Int(team.monster4)
            let m_4 = monsters[id4]

            let id5 = Int(team.monster5)
            let m_5 = monsters[id5]

            let m_6 = monsters[id]
            
            
            
            let img_url = base_img_url + m_1.image40_href!
            cell.m1.setImageFromURl(stringImageUrl: img_url)
            let img_url2 = base_img_url + m_2.image40_href!
            cell.m2.setImageFromURl(stringImageUrl: img_url2)
            let img_url3 = base_img_url + m_3.image40_href!
            cell.m3.setImageFromURl(stringImageUrl: img_url3)
            let img_url4 = base_img_url + m_4.image40_href!
            cell.m4.setImageFromURl(stringImageUrl: img_url4)
            let img_url5 = base_img_url + m_5.image40_href!
            cell.m5.setImageFromURl(stringImageUrl: img_url5)
            let img_url6 = base_img_url + m_6.image40_href!
            cell.m6.setImageFromURl(stringImageUrl: img_url6)
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
    
//    @IBAction func add_new_team(_ sender: Any) {
//        addDefaultTeam()
//        self.teamlistview.reloadData()
//    }
    

}
