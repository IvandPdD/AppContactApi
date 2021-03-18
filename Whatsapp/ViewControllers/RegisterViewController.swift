//
//  RegisterViewController.swift
//  Whatsapp
//
//  Created by user176708 on 2/27/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var boxNameRegister: UITextField!
        
    @IBOutlet weak var boxEmailRegister: UITextField!
        
    @IBOutlet weak var boxPasswordRegister: UITextField!
        
    @IBOutlet weak var boxRepPasswordRegister: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
        
    override func viewDidLoad() {
            
        super.viewDidLoad()
    }
        
        
    @IBAction func Register(_ sender: Any) {
            
        NetworkManager.shared.register(name: boxNameRegister.text!, email: boxEmailRegister.text!, password: boxPasswordRegister.text!, password_confirmation: boxRepPasswordRegister.text!,completionHandler:{
            success in
            if success{
                self.boxNameRegister.text = ""
                self.boxEmailRegister.text = ""
                self.boxPasswordRegister.text = ""
                self.boxRepPasswordRegister.text = ""
                
                
                let alert = UIAlertController(title: "Registro", message: "Ha creado su usuario satisfactoriamente, haga login", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Registro", message: "Ha ocurrido un error, vuelva a intentarlo más tarde", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Return", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
 }

