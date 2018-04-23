//
//  AddToTeamViewController.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/10/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class AddToTeamViewController: UIViewController {


    @IBOutlet weak var m1: UITextField!
    @IBOutlet weak var m2: UITextField!
    @IBOutlet weak var m3: UITextField!
    @IBOutlet weak var m4: UITextField!
    @IBOutlet weak var m5: UITextField!
    @IBOutlet weak var m6: UITextField!


    @IBAction func saveTeam(_ sender: Any) {
        addCandidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCandidate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Team", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(Int(m1.text!), forKey: "monster1")
        item.setValue(Int(m2.text!), forKey: "monster2")
        item.setValue(Int(m3.text!), forKey: "monster3")
        item.setValue(Int(m4.text!), forKey: "monster4")
        item.setValue(Int(m5.text!), forKey: "monster5")
        item.setValue(Int(m6.text!), forKey: "monster6")

        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save candidate.", err)
        }
        
        super.tabBarController?.viewControllers![1].viewWillAppear(true)
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
