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
    
    var monsterName:String?
    var maxhp:Int?
    var maxatk:Int?
    var maxrcv:Int?
    var activeskill:String?
    var leaderskill:String?
    var m_id:Int?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Monster View"

        // Do any additional setup after loading the view.
        name.text! = self.monsterName!
        max_hp.text! = String(self.maxhp!)
        max_atk.text! = String(self.maxatk!)
        max_rcv.text! = String(self.maxrcv!)
        active_skill.text! = self.activeskill!
        leader_skill.text! = self.leaderskill!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "addtoteamsegue") {
            let addVC = segue.destination as! AddToTeamViewController
            addVC.m_id = self.m_id!
            addVC.name = self.monsterName!
        }
    }
}
