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

    @IBOutlet weak var teamnumber: UITextField!
    @IBOutlet weak var slotnumber: UITextField!
    @IBOutlet weak var monster_label: UILabel!
    
    var teams: [NSManagedObject] = []

    
    var m_id:Int?
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.monster_label.text = self.name! + ",  # " + String(self.m_id!)

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
//        item.setValue(firstName.text, forKey: "firstName")
//        item.setValue(lastName.text, forKey: "lastName")
        
        
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save candidate.", err)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Team")
        do {
            teams = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print ("Failed to retrieve teams", err)
        }
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
