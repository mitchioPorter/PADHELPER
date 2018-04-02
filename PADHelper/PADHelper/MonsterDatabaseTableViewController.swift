//
//  MonsterDatabaseTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/1/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class MonsterDatabaseTableViewController: UITableViewController {
    
    
    // Struct to represent each monster found in the PADHerder api
    // uses optional values since some of the values may be null, i.e. leader skill, types, active skills, etc
    struct Monster: Codable {
        var active_skill:String?
        var atk_max:Int?
        var atk_min:Int?
        var atk_scale:Double?
        var awoken_skills:[Int]?
        var element:Int?
        var element2:Int?
        var feed_xp:Double?
        var hp_max:Int?
        var hp_min:Int?
        var hp_scale:Double?
        var id:Int?
        var jp_only:Bool?
        var leader_skill:String?
        var max_level:Int?
        var name:String?
        var rarity:Int?
        var rcv_max:Int?
        var rcv_min:Int?
        var rcv_scale:Double?
        var team_cost:Int?
        var type:Int?
        var type2:Int?
        var xp_curve:Int?
    }

    // url for PadHerder monster api
    let api_url:String = "https://www.padherder.com/api/monsters/"
    
    var monsters:[Monster]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the url
        guard let url = URL(string: api_url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let monsterData = try JSONDecoder().decode([Monster].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    self.monsters = monsterData
                }

            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
