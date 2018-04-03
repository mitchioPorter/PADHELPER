//
//  MonsterDatabaseTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/1/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import Foundation

class MonsterDatabaseTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var monstertable: UITableView!
    
    @IBOutlet weak var monstersearch: UISearchBar!
    
    // Struct to represent each monster found in the PADHerder api
    // uses optional values since some of the values may be null, i.e. leader skill, types, active skills, etc
    struct Monster: Decodable {
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
        var type3:Int?
        var xp_curve:Int?
        var image40_href:String?
        var image60_href:String?
    }
 
    // url for PadHerder monster api
    let monster_api_url:String = "https://www.padherder.com/api/monsters/"
    
    // url for PadHerder leader skill api
    let leader_skill_api_url:String = "https://www.padherder.com/api/leader_skills/"
    
    // url for PadHerder active skill api
    let active_skill_api_url:String = "https://www.padherder.com/api/active_skills/"
    
    // url for PadHerder awakening api
    let awakening_api_url:String = "https://www.padherder.com/api/awakenings/"
    
    // PadHerder url for getting images
    let base_url:String = "https://www.padherder.com/"
    
    
    // array of Monster objects pulled from the API
    var monsters:[Monster] = []
    
    // array of filtered monsters for the search bar
    var filteredMonsters:[Monster] = []
    
    // a bool to tell when searching
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monstersearch.delegate = self
        monstersearch.returnKeyType = UIReturnKeyType.done
        self.title = "Monster Database"
        
        fillMonsterData()
    }
    
    private func fillMonsterData() {
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        guard let url = URL(string: monster_api_url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            // Implement JSON decoding and parsing
            do {
                // Decode retrived data with JSONDecoder and assing type of Article object
                let monsterData = try JSONDecoder().decode([Monster].self, from: data)
                
                // Get back to the main queue
                DispatchQueue.main.async {
                    self.monsters = monsterData
                    self.monstertable.reloadData()
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching) {
            return filteredMonsters.count
        }
        return monsters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell", for: indexPath)
        
        
        if (isSearching) {
            cell.textLabel!.text! = filteredMonsters[indexPath.row].name!
            cell.detailTextLabel!.text! = String(filteredMonsters[indexPath.row].id!)
        }
            
        else {
            cell.textLabel!.text! = monsters[indexPath.row].name!
            cell.detailTextLabel!.text! = String(monsters[indexPath.row].id!)
        }

        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            isSearching = false
            view.endEditing(true)
            monstertable.reloadData()
        }
        
        else {
            isSearching = true
            filteredMonsters = monsters.filter({$0.name!.contains(searchBar.text!) || $0.id! == Int(searchBar.text!)})
            monstertable.reloadData()
            }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "monsterviewsegue") {
            if let monsterView = segue.destination as? MonsterView {
                // Get the current table entry's index
                let index = self.tableView.indexPathForSelectedRow?.row
                var monster:Monster
                if (isSearching) {
                    monster = filteredMonsters[index!]
                }
                else {
                    monster = monsters[index!]
                }
                monsterView.monsterName = monster.name!
                monsterView.maxhp = monster.hp_max!
                monsterView.maxatk = monster.atk_max!
                monsterView.maxrcv = monster.rcv_max!
                monsterView.activeskill = monster.active_skill!
                monsterView.leaderskill = monster.leader_skill!
            }
        }
    }
}
