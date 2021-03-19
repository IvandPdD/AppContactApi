//
//  LoginViewController.swift
//  Whatsapp
//
//  Created by user176708 on 2/27/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var boxEmail: UITextField!
        
    @IBOutlet weak var boxPassword: UITextField!
        
    @IBOutlet weak var buttonLogin: UIButton!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
        
        
    @IBAction func login(_ sender: Any){
        
        let activityIndicator = UIActivityIndicatorView() // Create the activity indicator
                view.addSubview(activityIndicator) // add it as a  subview
        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.8) // put in the middle
                activityIndicator.startAnimating() // Start animating
            
        if (boxEmail == nil || boxPassword == nil ){
                
            alertEmptyBox()
        }else{
                NetworkManager.shared.login(email: boxEmail.text!, password: boxPassword.text!, completionHandler: {
                success in
                
                if success{
                    
                    activityIndicator.stopAnimating()
                    
                    print("login")
                    
                            self.performSegue(withIdentifier: "buttonlogin", sender: PageViewController.self)
                        
                    
                }else{
                    
                    activityIndicator.stopAnimating()
                    
                    let alert = UIAlertController(title: "Login", message: "Datos incorrectos", preferredStyle: .alert)
                        
                    alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                            
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
        }
    }
    
        func alertEmptyBox(){
                    
            if(boxEmail.text == nil){
                
                let alert = UIAlertController(title: "Login", message: "No has introducido ningun email", preferredStyle: .alert)
                        
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                present(alert, animated: true, completion: nil)
                
            }
            
            if(boxPassword.text == nil){
                
                let alert = UIAlertController(title: "Login", message: "No has introducido ninguna contraseña", preferredStyle: .alert)
                        
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                present(alert, animated: true, completion: nil)
                        
            }
        }
    
}
