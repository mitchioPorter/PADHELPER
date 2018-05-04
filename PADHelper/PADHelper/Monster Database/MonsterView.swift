//
//  MonsterView.swift
//  PADHelper
//
//  Created by Rohil Thopu on 4/2/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

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
    
    @IBOutlet weak var hpmult: UILabel!
    @IBOutlet weak var atkmult: UILabel!
    @IBOutlet weak var rcvmult: UILabel!
    
    @IBOutlet weak var ability: UILabel!
    
    var m_id:Int?
    
    var mnstr:Monster?

    
    var base_img_url = "https://www.padherder.com"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorites"
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addFavorites))
        navigationItem.rightBarButtonItem = button
        
        
        loadLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addFavorites() {
        var exists = false
        

        if favorites.count != 0 {
            
            for item in favorites {
                let fav = item as! Favorite
                let favID:Int = Int(fav.fave)
                if favID == mnstr!.id! {
                    exists = true
                }
            }
        }
        
        if !exists {
            addFavorite()
            let alert = UIAlertController(title: "Favorite", message: "This monster has been added to Favorites!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Favorite", message: "This monster already exists in favorites.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func addFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(mnstr!.id!, forKey: "fave")
        do {
            try managedContext.save()
        } catch let err as NSError {
            print("Failed to save candidate.", err)
        }
        
        self.tabBarController?.viewControllers![2].viewWillAppear(true)
        self.tabBarController?.viewControllers![2].viewDidLoad()
        
    }
    
    private func loadLabels() {
        mnstr = getMonster(id: Int(m_id!))
        
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
            ability.text = api_active_skill_list.filter({$0.name! == mnstr!.active_skill!})[0].effect!
        }
        else {
            active_skill.text! = "This monster has no active skill."
            ability.text = ""
        }
        
        
        if (mnstr!.leader_skill != nil) {
            leader_skill.text! = mnstr!.leader_skill!
            
            let skill = api_leader_skill_list.filter({$0.name! == mnstr!.leader_skill!})[0]
            
            let skill_effect = skill.effect!
            effect.numberOfLines = 0
            effect.lineBreakMode = .byWordWrapping
            effect.text = skill_effect
            
            if skill.hp_mult == 0 {
                hpmult.text = "No Data Available"
                atkmult.text = "No Data Available"
                rcvmult.text = "No Data Available"
            }
            else {
                hpmult.text = String(skill.hp_mult!)
                atkmult.text = String(skill.atk_mult!)
                rcvmult.text = String(skill.rcv_mult!)
            }
            

        }

        else {
            leader_skill.text! = "This monster has no leader skill."
            effect.text = ""
            hpmult.text = "1.0"
            atkmult.text = "1.0"
            rcvmult.text = "1.0"
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
