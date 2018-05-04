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
    
    var redDam:Int = 0
    var greenDam:Int = 0
    var blueDam:Int = 0
    var lightDam:Int = 0
    var darkDam:Int = 0
    var rcvAmt:Int = 0
    
    var comboMultiplier: Double = 0.0
    var totalCombo: Int = 0
    
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
        mnstr1 = getMonster(id: Int(teamIDs[0]))
        mnstr2 = getMonster(id: Int(teamIDs[1]))
        //side hos
        mnstr3 = getMonster(id: Int(teamIDs[2]))
        mnstr4 = getMonster(id: Int(teamIDs[3]))
        mnstr5 = getMonster(id: Int(teamIDs[4]))
        mnstr6 = getMonster(id: Int(teamIDs[5]))
        
//        print("\(mnstr1?.element ?? 100)")
//        print("\(mnstr2?.element ?? 100)")
//        print("\(mnstr3?.element ?? 100)")
//        print("\(mnstr4?.element ?? 100)")
//        print("\(mnstr5?.element ?? 100)")

        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                
                baseDamageCalculator(mon:mnstr1!)
                baseDamageCalculator(mon:mnstr2!)
                baseDamageCalculator(mon:mnstr3!)
                baseDamageCalculator(mon:mnstr4!)
                baseDamageCalculator(mon:mnstr5!)
                baseDamageCalculator(mon:mnstr6!)
                
                
                
                let rCombo:Int = Int(RedCombo.text!)!
                let gCombo:Int = Int(GreenCombo.text!)!
                let bCombo:Int = Int(BlueCombo.text!)!
                let lCombo:Int = Int(LightCombo.text!)!
                let dCombo:Int = Int(DarkCombo.text!)!
                let hCombo:Int = Int(HeartCombo.text!)!
                let oCombo:Int = Int(OtherCombo.text!)!
                
                
                calDam.rCombo = rCombo
                calDam.gCombo = gCombo
                calDam.bCombo = bCombo
                calDam.lCombo = lCombo
                calDam.dCombo = dCombo
                calDam.hCombo = hCombo
                
                let halfCombo = rCombo + gCombo + bCombo
                let halfCombo2 = lCombo + dCombo + hCombo + oCombo
                
                let totalCombo = halfCombo + halfCombo2
                
                
                calculateDamage()
                calDam.comboMultiplier = comboMultiplier
                
                calDam.redDamage = redDam
                calDam.blueDamage = blueDam
                calDam.greenDamage = greenDam
                calDam.lightDamage = lightDam
                calDam.darkDamage = darkDam
                calDam.recoveryAmount = rcvAmt
                calDam.totalCombo = totalCombo
                
            }
        }
    }
    
    func baseDamageCalculator(mon:Monster){
        //0 = r
        //1 = b
        //2 = g
        //3 = l
        //4 = d
        
        rcvAmt += mon.rcv_max!
        
        if(mon.element == 0){
            redDam += mon.atk_max!
        }
        else if(mon.element == 1){
            blueDam += mon.atk_max!
        }
        else if(mon.element == 2){
            greenDam += mon.atk_max!
        }
        else if(mon.element == 3){
            lightDam += mon.atk_max!
        }
        else if(mon.element == 4){
            darkDam += mon.atk_max!
        }
        
        if(mon.element2 == 0){
            if(mon.element2 == mon.element){
                redDam += Int(mon.atk_max! / 10)
            }
            else{
                redDam += Int(3 * mon.atk_max! / 10)
            }
        }
        else if(mon.element2 == 1){
            if(mon.element2 == mon.element){
                blueDam += Int(mon.atk_max! / 10)
            }
            else{
                blueDam += Int(3 * mon.atk_max! / 10)
            }
        }
        else if(mon.element2 == 2){
            if(mon.element2 == mon.element){
                greenDam += Int(mon.atk_max! / 10)
            }
            else{
                greenDam += Int(3 * mon.atk_max! / 10)
            }
        }
        else if(mon.element2 == 3){
            if(mon.element2 == mon.element){
                lightDam += Int(mon.atk_max! / 10)
            }
            else{
                lightDam += Int(3 * mon.atk_max! / 10)
            }
        }
        else if(mon.element2 == 4){
            if(mon.element2 == mon.element){
                darkDam += Int(mon.atk_max! / 10)
            }
            else{
                darkDam += Int(3 * mon.atk_max! / 10)
            }
        }
        
    }
    
    func calculateDamage(){
        if((totalCombo > 1)){
           comboMultiplier = Double(1 + ((totalCombo - 1) / 4) * redDam)
            if(comboMultiplier > 3.25){
                comboMultiplier = 3.25
            }
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }

}
