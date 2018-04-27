//
//  MakeTeamTableView.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/27/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class MakeTeamTableView: UITableViewController {
    @IBOutlet var teamtable: UITableView!
    
    var newTeam:[Monster] = [api_monster_list[0], api_monster_list[0], api_monster_list[0], api_monster_list[0], api_monster_list[0], api_monster_list[0]]
    
    @IBAction func addTeam(_ sender: Any) {
        addCandidate()
        self.navigationController!.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        teamtable.rowHeight = 100
        teamtable.reloadData()
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
        return newTeam.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell", for: indexPath) as! MonsterCell
    
    
        let currentMonster:Monster = newTeam[indexPath.row]
        
        cell.name.text = currentMonster.name!
        cell.name.isHidden = false
        
        cell.id.text = String(currentMonster.id!)
        cell.rarity.text = String(currentMonster.rarity!) + "*"
        cell.hp.text = String(currentMonster.hp_max!)
        cell.atk.text = String(currentMonster.atk_max!)
        cell.rcv.text = String(currentMonster.rcv_max!)
        
        let url = URL(string: base_url + currentMonster.image40_href!)
        
        cell.img.kf.setImage(with: url)
    
    

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
        if segue.identifier == "choosesegue" {
            if let vc = segue.destination as? SelectFromMonsterDB {
                vc.slot = teamtable.indexPathForSelectedRow?.row
            }
        }
    }
 
    @IBAction func sendtoAdd(segue: UIStoryboardSegue) {
        let vc = segue.source as! SelectFromMonsterDB
        if let selectedMonster = vc.chosenMonster {
            let slot = vc.slot!
            newTeam[slot] = selectedMonster
            teamtable.reloadData()
        }
    }

    func addCandidate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(Int(newTeam[0].id!), forKey: "monster1")
        item.setValue(Int(newTeam[1].id!), forKey: "monster2")
        item.setValue(Int(newTeam[2].id!), forKey: "monster3")
        item.setValue(Int(newTeam[3].id!), forKey: "monster4")
        item.setValue(Int(newTeam[4].id!), forKey: "monster5")
        item.setValue(Int(newTeam[5].id!), forKey: "monster6")
        item.setValue("Team", forKey: "name")
        
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save candidate.", err)
        }
        
        super.tabBarController?.viewControllers![1].viewWillAppear(true)
    }
}
