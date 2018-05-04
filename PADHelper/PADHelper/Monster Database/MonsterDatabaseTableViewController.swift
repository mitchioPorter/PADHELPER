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
import SwiftyJSON
import Alamofire


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


struct Leader_Skill {
    var hp_mult:Double?
    var atk_mult:Double?
    var rcv_mult:Double?
    var types:[Double]?
    var name:String?
    var effect:String?
}

func getType(type:Int) -> String {
    switch type {
    case 0:
        return "Evo Material"
    case 1:
        return "Balanced"
    case 2:
        return "Physical"
    case 3:
        return "Healer"
    case 4:
        return "Dragon"
    case 5:
        return "God"
    case 6:
        return "Attacker"
    case 7:
        return "Devil"
    case 12:
        return "Awoken Skill Material"
    case 13:
        return "Protected"
    case 14:
        return "Enhance Material"
    default:
        return "None"
    }
}

func getMonster(id:Int) -> Monster {
    return api_monster_list.filter({$0.id! == id})[0]
}


// array of Monster objects pulled from the API
var api_monster_list:[Monster] = []

// array of leader skills pulled from the API
var api_leader_skill_list:[Leader_Skill] = []

// array of active skills pulled from the API
var api_active_skill_list:[Active_Skill] = []



/// URLS

// PadHerder url for getting images
let base_url:String = "https://www.padherder.com/"



extension MonsterDatabaseTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



class MonsterDatabaseTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var slot:Int?
    
    
    @IBOutlet var monstertable: UITableView!
    
    
    
    // url for PadHerder monster api
    let monster_api_url:String = "https://www.padherder.com/api/monsters/"
    
    // url for PadHerder leader skill api
    let leader_skill_api_url:String = "https://www.padherder.com/api/leader_skills/"
    
    // url for PadHerder active skill api
    let active_skill_api_url:String = "https://www.padherder.com/api/active_skills/"
    
    // url for PadHerder awakening api
    let awakening_api_url:String = "https://www.padherder.com/api/awakenings/"


    
    
    // list of monsters converted to monster objects
    var final_monster_list:[Monster] = []
    
    
    
    // DATABASE SEARCHING VARS
    
    // array of filtered monsters for the search bar
    var filteredMonsters:[Monster] = []
    
    
    var monstersearch:UISearchController!
    
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Monster Database"
        
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds

        setupView()
        
        fillMonsterData()
        fillLeaderSkillData()
        fillActiveSkillData()
        self.monstertable.reloadData()
        
        //        fillActiveSkillData()
        //        fillLeaderSkillData()
        
    }
    
    private func setupView() {
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = monstersearch
        } else {
            tableView.tableHeaderView = monstersearch.searchBar
        }
        
        monstersearch = UISearchController(searchResultsController: nil)
        
        monstersearch.searchResultsUpdater = self
        monstersearch.obscuresBackgroundDuringPresentation = false
        monstersearch.searchBar.placeholder = "Search Monsters"
        navigationItem.searchController = monstersearch
        monstersearch.isActive = true
        monstersearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.monstersearch.delegate = self
        self.monstersearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!) // not required when using UITableViewController
        
        
        
        self.monstertable.rowHeight = 85
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.monstersearch.isActive = false
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
        if (isFiltering()) {
            return filteredMonsters.count
        }
        return api_monster_list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell", for: indexPath) as! MonsterCell
        
        
        if (isFiltering()) {
      
            let currentMonster:Monster = filteredMonsters[indexPath.row]
            cell.name.text = currentMonster.name!
            cell.id.text = String(currentMonster.id!)
            cell.rarity.text = String(currentMonster.rarity!) + "*"
            cell.hp.text = String(currentMonster.hp_max!)
            cell.atk.text = String(currentMonster.atk_max!)
            cell.rcv.text = String(currentMonster.rcv_max!)

            let url = URL(string: base_url + currentMonster.image40_href!)

            cell.img.kf.setImage(with: url)
        
        }
        else {

            let currentMonster:Monster = api_monster_list[indexPath.row]

            cell.name.text = currentMonster.name!
            cell.id.text = String(currentMonster.id!)
            cell.rarity.text = String(currentMonster.rarity!) + "*"
            cell.hp.text = String(currentMonster.hp_max!)
            cell.atk.text = String(currentMonster.atk_max!)
            cell.rcv.text = String(currentMonster.rcv_max!)

            let url = URL(string: base_url + currentMonster.image40_href!)

            cell.img.kf.setImage(with: url)

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
                if (isFiltering()) {
                    monster = filteredMonsters[index!]
                }
                else {
                    monster = api_monster_list[index!]
                }
                monsterView.m_id = monster.id!
                
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
        
        activityIndicator.startAnimating()
        
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
                    self.activityIndicator.stopAnimating()
                    self.monstertable.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
    private func fillActiveSkillData() {
        let url = active_skill_api_url
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0...json.count {
                    let a_skill = Active_Skill(min_cooldown: Int(json[i]["min_cooldown"].stringValue), max_cooldwown: Int(json[0]["max_cooldown"].stringValue), name: json[i]["name"].stringValue, effect: json[i]["effect"].stringValue)                    
                    api_active_skill_list.append(a_skill)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fillLeaderSkillData() {
        let url = leader_skill_api_url
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0...json.count {
                    
                    var l_skill:Leader_Skill = Leader_Skill(hp_mult: 0, atk_mult: 0, rcv_mult: 0, types: [], name: json[i]["name"].stringValue, effect: json[i]["effect"].stringValue)
                    if json[i]["data"] != JSON.null {
                        l_skill.hp_mult = Double(json[i]["data"][0].stringValue)
                        l_skill.atk_mult = Double(json[i]["data"][1].stringValue)
                        l_skill.rcv_mult = Double(json[i]["data"][2].stringValue)
                    }
                    
                    api_leader_skill_list.append(l_skill)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // ADDED METHODS FOR UI FUNCTION

    
 
    
    // SEARCH CONTROLLER FUNCTIONS
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return monstersearch.searchBar.text?.isEmpty ?? true
    }
   
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredMonsters = api_monster_list.filter({$0.name!.lowercased().contains(searchText.lowercased()) || $0.id! == Int(searchText)})
 
        monstertable.reloadData()
    }
    
    func isFiltering() -> Bool {
        return monstersearch.isActive && !searchBarIsEmpty()
    }
    
    
    @objc func refresh() {
        // Code to refresh table view
        
        fillMonsterData()
        refreshControl?.endRefreshing()
        self.monstertable.reloadData()
    }
    
}
