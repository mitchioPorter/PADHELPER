//
//  IndividualTeamTableTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/23/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class IndividualTeamTableTableViewController: UITableViewController {
    
    @IBOutlet var teamView: UITableView!
    
    var team:Team?
    
    var teamIDs:[Int64] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getIDs()
        
        teamView.rowHeight = 85
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(seeStats))
        navigationItem.rightBarButtonItem = button
        teamView.reloadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func seeStats() {
        performSegue(withIdentifier: "statsegue", sender: self)
    }
    
    private func getIDs() {
        teamIDs.append(team!.monster1)
        teamIDs.append(team!.monster2)
        teamIDs.append(team!.monster3)
        teamIDs.append(team!.monster4)
        teamIDs.append(team!.monster5)
        teamIDs.append(team!.monster6)
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
        return teamIDs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell", for: indexPath) as! MonsterCell

        let id = teamIDs[indexPath.row]
        
        let currentMonster:Monster = getMonster(id: Int(id))
        
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
        if segue.identifier == "monsterview" {
            if let monsterView = segue.destination as? MonsterView {
                let index = self.teamView.indexPathForSelectedRow?.row
                monsterView.m_id = Int(teamIDs[index!])
            }
        }
        
        else if segue.identifier == "toDamSeque" {
            if let damCalc = segue.destination as? DamageCalculator {
                 damCalc.teamIDs = teamIDs
            }
        }
        else if segue.identifier == "statsegue" {
            if let statVC = segue.destination as? TeamStatsTableViewController {
                statVC.ids = self.teamIDs
            }
        }
    }
}
