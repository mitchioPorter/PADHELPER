//
//  LoginViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/9/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit


//  BIG NOTE AS TO THIS VIEW CONTROLLERS FUNCTIONALITY
//
// This controller will be the entry point for the generation of the monster database. As a result, this
// will be the delegate for the Monster Database Table View Controller to access a function to fetch from API.



class LoginViewController: UIViewController {
    
    // Struct to represent each monster found in the PADHerder api
    // uses optional values since some of the values may be null, i.e. leader skill, types, active skills, etc
    struct Monster: Decodable {
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
    
    
    // url for PadHerder monster api
    let monster_api_url:String = "https://www.padherder.com/api/monsters/"
    
    
    // ARRAYS FOR API DATA
    
    // array of Monster objects pulled from the API
    var api_monster_list:[Monster] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        fillMonsterData()
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
                    self.api_monster_list = monsterData
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
    

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        if segue.identifier == "postloginsegue" {
//
//            let monsterDB = segue.destination.tabBarController?.viewControllers![1] as! MonsterDatabaseTableViewController
//            monsterDB.api_monster_list = self.api_monster_list as! MonsterDatabaseTableViewController.Monster
//        }
//    }
//

}
