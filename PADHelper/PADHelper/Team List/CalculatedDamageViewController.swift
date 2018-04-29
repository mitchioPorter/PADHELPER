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
    
    var comboMultiplier: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //here is where the damge is calculated
        redDamage *= Int(Double(rCombo) * comboMultiplier)
        blueDamage *= Int(Double(bCombo) * comboMultiplier)
        greenDamage *= Int(Double(gCombo) * comboMultiplier)
        lightDamage *= Int(Double(lCombo) * comboMultiplier)
        darkDamage *= Int(Double(dCombo) * comboMultiplier)
        recoveryAmount *= Int(Double(hCombo) * comboMultiplier)
        totalDamage = redDamage + blueDamage + greenDamage + lightDamage + darkDamage
        
        rDam.text = "\(rCombo) combos for \(redDamage)"
        bDam.text = "\(gCombo) combos for \(blueDamage)"
        gDam.text = "\(bCombo) combos for \(greenDamage)"
        lDam.text = "\(lCombo) combos for \(lightDamage)"
        dDam.text = "\(dCombo) combos for \(darkDamage)"
        rAmt.text = "\(hCombo) combos for \(recoveryAmount)"
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
