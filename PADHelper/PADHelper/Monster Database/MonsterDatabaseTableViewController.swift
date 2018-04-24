//
//  MonsterDatabaseTableViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/1/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Kingfisher


// Struct to represent each monster found in the PADHerder api
// uses optional values since some of the values may be null, i.e. leader skill, types, active skills, etc
struct Monster: Codable {
    var active_skill:String?
    var atk_max:Int?
    var atk_min:Int?
    var awoken_skills:[Int]?
    var element:Int?
    var element2:Int?
    var hp_max:Int?
    var hp_min:Int?
    var id:Int?
    var jp_only:Bool?
    var leader_skill:String?
    var max_level:Int?
    var name:String?
    var rarity:Int?
    var rcv_max:Int?
    var rcv_min:Int?
    var team_cost:Int?
    var type:Int?
    var type2:Int?
    var type3:Int?
    var image40_href:String?
    var image60_href:String?
}

struct Active_Skill: Decodable {
    var min_cooldown:Int?
    var max_cooldwown:Int?
    var name:String?
    var effect:String?
}


struct Leader_Skill: Decodable {
    var data:[Int]?
    var name:String?
    var effect:String?
}


// array of Monster objects pulled from the API
var api_monster_list:[Monster] = []

// array of uiimages to cache the monster images

var img40:[UIImage] = []

var img60:[UIImage] = []



class MonsterDatabaseTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var monstertable: UITableView!
    
    @IBOutlet weak var monstersearch: UISearchBar!
    
 
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
    
    
    // ARRAYS FOR API DATA

    
    // array of leader skills pulled from the API
    var api_leader_skill_list:[Leader_Skill] = []
    
    // array of active skills pulled from the API
    var api_active_skill_list:[Active_Skill] = []
    
    
    // list of monsters converted to monster objects
    var final_monster_list:[Monster] = []
    
    
    
    // DATABASE SEARCHING VARS
    
    // array of filtered monsters for the search bar
    var filteredMonsters:[Monster] = []
    
    // a bool to tell when searching
    var isSearching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monstersearch.delegate = self
        monstersearch.returnKeyType = UIReturnKeyType.done
        self.title = "Monster Database"

        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!) // not required when using UITableViewController
        
        fillMonsterData()
        
        self.monstertable.rowHeight = 60
        self.monstertable.reloadData()
        
//        fillActiveSkillData()
//        fillLeaderSkillData()

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
        return api_monster_list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell", for: indexPath) as! MonsterCell
        
        
        if (isSearching) {
            let currentMonster:Monster = filteredMonsters[indexPath.row]
            
            cell.name.text = currentMonster.name!
            cell.id.text = String(currentMonster.id!)
            
            let url = URL(string: base_url + currentMonster.image40_href!)
            
            cell.img.kf.setImage(with: url)
        }
            
        else {
            
            let currentMonster:Monster = api_monster_list[indexPath.row]
            
            cell.name.text = currentMonster.name!
            cell.id.text = String(currentMonster.id!)
            
            let url = URL(string: base_url + currentMonster.image40_href!)
            
            cell.img.kf.setImage(with: url)
            
            print(currentMonster.id!)
        }

        return cell
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
                    monster = api_monster_list[index!]
                }
                monsterView.monsterName = monster.name!
                monsterView.maxhp = monster.hp_max!
                monsterView.maxatk = monster.atk_max!
                monsterView.maxrcv = monster.rcv_max!
                monsterView.activeskill = monster.active_skill!
                monsterView.m_id = monster.id!
                monsterView.img_40 = monster.image40_href
                
                if (monster.image60_href != nil) {
                    monsterView.img_60 = monster.image60_href!
                }
                
                // some monsters, such as assist evos, do not have a leader skill
                if monster.leader_skill != nil {
                    monsterView.leaderskill = monster.leader_skill!
                }
                else {
                    monsterView.leaderskill = "No Leader Skill available."
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    // PROCESSING FUNCTIONS
    
    
    
    // function to delete all records from Core Data
    private func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Monster")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
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
                    api_monster_list = monsterData
                    self.monstertable.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
    private func fillActiveSkillData() {
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        guard let url = URL(string: active_skill_api_url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            // Implement JSON decoding and parsing
            do {
                // Decode retrived data with JSONDecoder and assing type of Article object
                let monsterData = try JSONDecoder().decode([Active_Skill].self, from: data)
                
                // Get back to the main queue
                DispatchQueue.main.async {
                    self.api_active_skill_list = monsterData
                    self.monstertable.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
    private func fillLeaderSkillData() {
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        guard let url = URL(string: leader_skill_api_url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            // Implement JSON decoding and parsing
            do {
                // Decode retrived data with JSONDecoder and assing type of Article object
                let monsterData = try JSONDecoder().decode([Leader_Skill].self, from: data)
                
                // Get back to the main queue
                DispatchQueue.main.async {
                    self.api_leader_skill_list = monsterData
                    self.monstertable.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
    
    
    // ADDED METHODS FOR UI FUNCTION
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            isSearching = false
            view.endEditing(true)
            monstertable.reloadData()
        }
            
        else {
            isSearching = true
            filteredMonsters = api_monster_list.filter({$0.name!.lowercased().contains(searchBar.text!.lowercased()) || $0.id! == Int(searchBar.text!)})
            monstertable.reloadData()
        }
    }
    
    
    @objc func refresh() {
        // Code to refresh table view
        api_monster_list = []
        fillMonsterData()
        refreshControl?.endRefreshing()
        self.monstertable.reloadData()
    }
}
