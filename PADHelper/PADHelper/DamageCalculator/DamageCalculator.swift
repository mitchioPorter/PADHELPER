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
    
    public var teamIDs:[Int64] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view.
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
