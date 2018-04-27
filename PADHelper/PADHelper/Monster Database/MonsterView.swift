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
    @IBOutlet weak var max_hp: UILabel!
    @IBOutlet weak var max_atk: UILabel!
    @IBOutlet weak var max_rcv: UILabel!
    @IBOutlet weak var active_skill: UILabel!
    @IBOutlet weak var leader_skill: UILabel!
    @IBOutlet weak var monster_img: UIImageView!


    @IBOutlet weak var addmonster: UIButton!
    
    var m_id:Int?
    
    var mnstr:Monster?

    
    var base_img_url = "https://www.padherder.com"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Monster View"
        
        mnstr = api_monster_list.filter({$0.id! == Int(m_id!)})[0]


        // Do any additional setup after loading the view.
        name.text! = mnstr!.name!
        max_hp.text! = String(mnstr!.hp_max!)
        max_atk.text! = String(mnstr!.atk_max!)
        max_rcv.text! = String(mnstr!.rcv_max!)
        
        if (mnstr!.active_skill != nil) {
            active_skill.text! = mnstr!.active_skill!
        }
        else {
            active_skill.text! = "This monster has no active skill."
        }
        
        
        if (mnstr!.leader_skill != nil) {
            leader_skill.text! = mnstr!.leader_skill!
        }
        else {
            leader_skill.text! = "This monster has no leader skill."
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
}
