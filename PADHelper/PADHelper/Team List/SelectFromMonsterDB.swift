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


class SelectFromMonsterDB: UITableViewController, UISearchBarDelegate {
    
    
    
    // FOR ADDING TO TEAM
    var slot:Int?
    
    var chosenMonster:Monster?
    
    
    @IBOutlet var monstertable: UITableView!
    
    @IBOutlet weak var monstersearch: UISearchBar!
    
    // DATABASE SEARCHING VARS
    
    // array of filtered monsters for the search bar
    var filteredMonsters:[Monster] = []
    
    // a bool to tell when searching
    var isSearching = false

    
    
    // url for PadHerder monster api
    let monster_api_url:String = "https://www.padherder.com/api/monsters/"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        monstersearch.delegate = self
        monstersearch.returnKeyType = UIReturnKeyType.done
        self.title = "Monster Database"

        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl!) // not required when using UITableViewController
        
        
        self.monstertable.rowHeight = 85
        self.monstertable.reloadData()

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
        if segue.identifier == "sendtoadd" {
            let index = monstertable.indexPathForSelectedRow?.row
            let mnstr:Monster?
            if isSearching {
                mnstr = filteredMonsters[index!]
            }
            else {
                mnstr = api_monster_list[index!]

            }
            
            chosenMonster = mnstr
        }
    }
    
    
    
    // ADDED METHODS FOR UI FUNCTION
    
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
