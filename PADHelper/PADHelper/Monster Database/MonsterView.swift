//
//  MonsterView.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/2/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class MonsterView: UIViewController {

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var active_skill: UILabel!
    @IBOutlet weak var leader_skill: UILabel!
    @IBOutlet weak var monster_img: UIImageView!
    @IBOutlet weak var effect: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var type3: UILabel!
    
    @IBOutlet weak var hprange: UILabel!
    @IBOutlet weak var atkrange: UILabel!
    @IBOutlet weak var rcvrange: UILabel!
    
    
    var m_id:Int?
    
    var mnstr:Monster?

    
    var base_img_url = "https://www.padherder.com"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Monster View"
        loadLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadLabels() {
        mnstr = api_monster_list.filter({$0.id! == Int(m_id!)})[0]
        
        name.text! = mnstr!.name!
        id.text = String(mnstr!.id!)
        
        
        hprange.text = String(mnstr!.hp_min!) + " - " + String(mnstr!.hp_max!)
        atkrange.text = String(mnstr!.atk_min!) + " - " + String(mnstr!.atk_max!)
        rcvrange.text = String(mnstr!.rcv_min!) + " - " + String(mnstr!.rcv_max!)


        type1.text = getType(type: mnstr!.type!)
        if mnstr?.type2 != nil {
            type2.text = getType(type: mnstr!.type2!)
        }
        else {
            type2.text = "None"
        }
        if mnstr?.type3 != nil {
            type3.text = getType(type: mnstr!.type3!)
        }
        else {
            type3.text = "None"
        }
        
        
        if (mnstr!.active_skill != nil) {
            active_skill.text! = mnstr!.active_skill!
        }
        else {
            active_skill.text! = "This monster has no active skill."
        }
        
        
        if (mnstr!.leader_skill != nil) {
            leader_skill.text! = mnstr!.leader_skill!
            let skill_effect = api_leader_skill_list.filter({$0.name!.contains(mnstr!.leader_skill!)})[0].effect!
            effect.numberOfLines = 0
            effect.lineBreakMode = .byWordWrapping
            
            effect.text = skill_effect
        }
        else {
            leader_skill.text! = "This monster has no leader skill."
            effect.text = ""
        }
        
        if (mnstr!.image60_href != nil) {
            let img_url = base_img_url + mnstr!.image60_href!
            let url = URL(string: img_url)
            monster_img.kf.setImage(with: url)
        }
        else {
            let img_url = base_img_url + mnstr!.image40_href!
            let url = URL(string: img_url)
            monster_img.kf.setImage(with: url)
        }
    }

    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
}
