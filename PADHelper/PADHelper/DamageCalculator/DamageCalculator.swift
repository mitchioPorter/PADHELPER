//
//  DamageCalculator.swift
//  PADHelper
//
//  Created by Mitchio Porter on 4/26/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit


class DamageCalculator: UIViewController {

    @IBOutlet weak var Monster1Name: UILabel!
    @IBOutlet weak var Monster1Image: UIImageView!
    @IBOutlet weak var Monster2Image: UIImageView!
    @IBOutlet weak var Monster2Name: UILabel!
    @IBOutlet weak var Monster1Ability: UILabel!
    @IBOutlet weak var Monster2Ability: UILabel!
    
    
    @IBOutlet weak var RedCombo: UITextField!
    @IBOutlet weak var BlueCombo: UITextField!
    @IBOutlet weak var GreenCombo: UITextField!
    @IBOutlet weak var LightCombo: UITextField!
    @IBOutlet weak var DarkCombo: UITextField!
    @IBOutlet weak var HeartCombo: UITextField!
    @IBOutlet weak var OtherCombo: UITextField!
    
    
    @IBOutlet weak var outputNotif: UILabel!
    @IBOutlet weak var Damagebutone: UIButton!
    
    public var teamIDs:[Int64] = []
    
    
    var mnstr1:Monster?
    var mnstr2:Monster?
    var mnstr3:Monster?
    var mnstr4:Monster?
    var mnstr5:Monster?
    var mnstr6:Monster?
    
    var base_img_url1 = "https://www.padherder.com"
    var base_img_url2 = "https://www.padherder.com"
    
    @IBAction func CalculateDamage(_ sender: Any) {
        if(shouldPerformSegue(withIdentifier: "damStats", sender:Damagebutone)){
            //performSegue(withIdentifier: "damStats", sender: Damagebutone)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view.
        
        // this sets the leader skills and stuff
        //Monster1Name
        mnstr1 = api_monster_list.filter({$0.id! == Int(teamIDs[0])})[0]
        mnstr2 = api_monster_list.filter({$0.id! == Int(teamIDs[5])})[0]
        //side hos
        mnstr3 = api_monster_list.filter({$0.id! == Int(teamIDs[1])})[0]
        mnstr4 = api_monster_list.filter({$0.id! == Int(teamIDs[2])})[0]
        mnstr5 = api_monster_list.filter({$0.id! == Int(teamIDs[3])})[0]
        mnstr6 = api_monster_list.filter({$0.id! == Int(teamIDs[4])})[0]
        
        Monster1Name.text! = mnstr1!.name!
        
        if (mnstr1!.leader_skill != nil) {
            Monster1Ability.text! = mnstr1!.leader_skill!
        }
        else {
            Monster1Ability.text! = "This monster has no leader skill."
        }
        if (mnstr1!.image60_href != nil) {
            let img_url = base_img_url1 + mnstr1!.image60_href!
            let url = URL(string: img_url)
            Monster1Image.kf.setImage(with: url)
        }
        else {
            let img_url = base_img_url1 + mnstr1!.image40_href!
            let url = URL(string: img_url)
            Monster1Image.kf.setImage(with: url)
        }
        
        
        mnstr2 = api_monster_list.filter({$0.id! == Int(teamIDs[5])})[0]
        
        Monster2Name.text! = mnstr2!.name!
        
        if (mnstr2!.leader_skill != nil) {
            Monster2Ability.text! = mnstr2!.leader_skill!
        }
        else {
            Monster2Ability.text! = "This monster has no leader skill."
        }
        if (mnstr2!.image60_href != nil) {
            let img_url = base_img_url2 + mnstr2!.image60_href!
            let url = URL(string: img_url)
            Monster2Image.kf.setImage(with: url)
        }
        else {
            let img_url = base_img_url2 + mnstr2!.image40_href!
            let url = URL(string: img_url)
            Monster2Image.kf.setImage(with: url)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isNumeric(a: String) -> Bool {
        return Double(a) != nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
    
    //this overides the sewue as long as the parameter are met
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(RedCombo.text == "" || BlueCombo.text == "" || GreenCombo.text == "" || DarkCombo.text == "" || LightCombo.text == "" || HeartCombo.text == "" || OtherCombo.text == "") || !(isNumeric(a: GreenCombo.text!) && isNumeric(a: RedCombo.text!) && isNumeric(a: BlueCombo.text!) && isNumeric(a: LightCombo.text!) && isNumeric(a: DarkCombo.text!) && isNumeric(a: HeartCombo.text!) && isNumeric(a: OtherCombo.text!)){
                outputNotif.text = "FILL IN ALL THE BLANKS WITH NUMBERS"
                return false
            }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDamStats" {
            if let calDam = segue.destination as? CalculatedDamageViewController {
                calDam.rCombo = Int(RedCombo.text!)!
                calDam.gCombo = Int(GreenCombo.text!)!
                calDam.bCombo = Int(BlueCombo.text!)!
                calDam.lCombo = Int(LightCombo.text!)!
                calDam.dCombo = Int(DarkCombo.text!)!
                calDam.hCombo = Int(HeartCombo.text!)!
            }
        }
    }


}
