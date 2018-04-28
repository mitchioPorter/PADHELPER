//
//  CalculatedDamageViewController.swift
//  PADHelper
//
//  Created by Mitchio Porter on 4/28/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit

class CalculatedDamageViewController: UIViewController {

    @IBOutlet weak var rDam: UILabel!
    @IBOutlet weak var bDam: UILabel!
    @IBOutlet weak var gDam: UILabel!
    @IBOutlet weak var lDam: UILabel!
    @IBOutlet weak var dDam: UILabel!

    @IBOutlet weak var rAmt: UILabel!
    @IBOutlet weak var tDam: UILabel!
    
    
    var rCombo: Int = 0
    var gCombo: Int = 0
    var bCombo: Int = 0
    var lCombo: Int = 0
    var dCombo: Int = 0
    var hCombo: Int = 0
    var tCombo: Int = 0
    var oCombo: Int = 0
    
    
    var redDamage: Int = 0
    var greenDamage: Int = 0
    var blueDamage: Int = 0
    var lightDamage: Int = 0
    var darkDamage: Int = 0
    var totalCombo: Int = 0
    var totalDamage: Int = 0
    var recoveryAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //here is where the damge is calculated
        redDamage = rCombo * 1000
        blueDamage = bCombo * 2000
        greenDamage = gCombo * 3000
        lightDamage = lCombo * 4000
        darkDamage = dCombo * 5000
        recoveryAmount = hCombo * 1000
        totalCombo =  rCombo + bCombo + gCombo + lCombo + dCombo + oCombo
        totalDamage = redDamage + blueDamage + greenDamage + lightDamage + darkDamage
        
        rDam.text = "\(rCombo) X 1000 Damage = \(redDamage)"
        bDam.text = "\(gCombo) X 2000 Damage = \(blueDamage)"
        gDam.text = "\(bCombo) X 3000 Damage = \(greenDamage)"
        lDam.text = "\(lCombo) X 4000 Damage = \(lightDamage)"
        dDam.text = "\(dCombo) X 2000 Damage = \(darkDamage)"
        
        rAmt.text = "\(hCombo) X 1000 Damage = \(1000*hCombo)"
        tDam.text = "\(totalCombo) combos for \(totalDamage)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
