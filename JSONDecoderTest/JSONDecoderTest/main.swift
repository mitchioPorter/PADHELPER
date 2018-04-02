//
//  main.swift
//  JSONDecoderTest
//
//  Created by Rohil Thopu on 4/1/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import Foundation

// url for PadHerder monster api
let api_url:String = "https://www.padherder.com/api/monsters/"

struct Monster: Codable {
    var active_skill:String
    var atk_max:Int
    var atk_min:Int
    var atk_scale:Double
    var awoken_skills:[String]
    var element:Int
    var element2:Int
    var feed_xp:Double
    var hp_max:Int
    var hp_min:Int
    var hp_scale:Double
    var id:Int
    var jp_only:Bool
    var leader_skill:String
    var max_level:Int
    var name:String
    var rarity:Int
    var rcv_max:Int
    var rcv_min:Int
    var rcv_scale:Double
    var team_cost:Int
    var type:Int
    var type2:Int
    var xp_curve:Int
}

var monsters:[Monster] = []

// load the url
let url = URL(string: api_url)

URLSession.shared.dataTask(with: url!) { (data, response, error) in
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
            monsters = monsterData
        }
        
    } catch let jsonError {
        print(jsonError)
    }
    
    
}.resume()

print (monsters.count)

