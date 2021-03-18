//
//  UserViewController.swift
//  Whatsapp
//
//  Created by user176708 on 3/8/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel?
    
    @IBOutlet weak var labelEmail: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getUser(completionHandler: { [self]
            user in
            if user != nil{
            
                print(user?.user.name)
                
                let defaults = UserDefaults.standard
                
                defaults.setValue(user?.user.id, forKey: "user_id")
                
                labelName?.text = user?.user.name
                
                labelEmail?.text = user?.user.email
            
            } else {
                
                let alert = UIAlertController(title: "User", message: "La peticion ha fallado", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
                
            }

        })
        
    }
    
    @IBAction func deleteUser(){
        
        let defaults = UserDefaults.standard
        
        let id = defaults.string(forKey: "user_id")
        
        NetworkManager.shared.deleteUser(id: id!, completionHandler: {
            success in
            if success{
                
                self.performSegue(withIdentifier: "eraseUser", sender: ViewViewController.self)
                
            }else{
                
                let alert = UIAlertController(title: "User", message: "La peticion ha fallado", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
                
            }
        })
        
    }
}
