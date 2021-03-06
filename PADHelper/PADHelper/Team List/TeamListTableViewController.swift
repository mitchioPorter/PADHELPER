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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team List"

        self.teamlistview.rowHeight = 100
        

        self.teamlistview.reloadData()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    

        let team = teams[indexPath.row] as! Team
        let id = Int(team.monster1)
        let id2 = Int(team.monster2)
        let id3 = Int(team.monster3)
        let id4 = Int(team.monster4)
        let id5 = Int(team.monster5)
        let id6 = Int(team.monster6)

        
        let m_1 = getMonster(id: id)
        let m_2 = getMonster(id: id2)
        let m_3 = getMonster(id: id3)
        let m_4 = getMonster(id: id4)
        let m_5 = getMonster(id: id5)
        let m_6 = getMonster(id: id6)

        
        
        let img_url = base_img_url + m_1.image40_href!
        
        var url = URL(string: img_url)
        cell.m1.kf.setImage(with: url)
        
        let img_url2 = base_img_url + m_2.image40_href!
        url = URL(string: img_url2)
        cell.m2.kf.setImage(with: url)
        
        let img_url3 = base_img_url + m_3.image40_href!
        url = URL(string: img_url3)
        cell.m3.kf.setImage(with: url)
        
        let img_url4 = base_img_url + m_4.image40_href!
        url = URL(string: img_url4)
        cell.m4.kf.setImage(with: url)
        
        let img_url5 = base_img_url + m_5.image40_href!
        url = URL(string: img_url5)
        cell.m5.kf.setImage(with: url)
        
        let img_url6 = base_img_url + m_6.image40_href!
        url = URL(string: img_url6)
        cell.m6.kf.setImage(with: url)
    

        cell.teamname.text! = team.name!

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "teamviewsegue" {
            if let teamView = segue.destination as? IndividualTeamTableTableViewController {
                // Get the current table entry's index
                let index = self.tableView.indexPathForSelectedRow?.row
                let team = teams[index!] as! Team
                teamView.team = team
            }
        }

    }
}
