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


extension SelectFromMonsterDB {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class SelectFromMonsterDB: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    
    
    
    // FOR ADDING TO TEAM
    var slot:Int?
    
    var chosenMonster:Monster?
    
    
    @IBOutlet var monstertable: UITableView!
    
    var monstersearch:UISearchController!
    
    // DATABASE SEARCHING VARS
    
    // array of filtered monsters for the search bar
    var filteredMonsters:[Monster] = []
    


    
    
    // url for PadHerder monster api
    let monster_api_url:String = "https://www.padherder.com/api/monsters/"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.monstertable.reloadData()

    }
    

    private func setupView() {
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = monstersearch
        } else {
            tableView.tableHeaderView = monstersearch.searchBar
        }
        
        monstersearch = UISearchController(searchResultsController: nil)
        
        monstersearch.isActive = true
        monstersearch.searchResultsUpdater = self
        monstersearch.obscuresBackgroundDuringPresentation = false
        monstersearch.searchBar.placeholder = "Search Monsters"
        navigationItem.searchController = monstersearch
        monstersearch.hidesNavigationBarDuringPresentation = true
        monstersearch.definesPresentationContext = true
        self.monstersearch.delegate = self
        self.monstersearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        self.monstertable.rowHeight = 85
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
        if segue.identifier == "sendtoadd" {
            let index = monstertable.indexPathForSelectedRow?.row
            let mnstr:Monster?
            if isFiltering() {
                mnstr = filteredMonsters[index!]
            }
            else {
                mnstr = api_monster_list[index!]

            }
            
            chosenMonster = mnstr
        }
    }
    
    
    
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
    
}
