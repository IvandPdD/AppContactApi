//
//  ForgotViewController.swift
//  Whatsapp
//
//  Created by user176708 on 3/7/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class ForgotViewController: UIViewController{
    
    @IBOutlet weak var boxEmail: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //logica funcion de olvidar contraseña, te manda un correo cn un form para resetear password
    
    @IBAction func forgot(){
        
        let activityIndicator = UIActivityIndicatorView() // Create the activity indicator
                view.addSubview(activityIndicator) // add it as a  subview
                activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.75) // put in the middle
                activityIndicator.startAnimating() // Start animating
        
        if(boxEmail == nil){
            
            alertEmptyBox()
            
        } else {
            
            NetworkManager.shared.forgot(email: boxEmail.text!, completionHandler: {
                success in
                if success{
                    self.boxEmail.text = nil
                    
                    activityIndicator.stopAnimating()
                    
                    let alert = UIAlertController(title: "Forgot", message: "Han enviado un email a su correo", preferredStyle: .alert)
                        
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    activityIndicator.stopAnimating()
                    
                    let alert = UIAlertController(title: "Forgot", message: "Datos incorrectos", preferredStyle: .alert)
                        
                    alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                            
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            
        }
    }
    
    func alertEmptyBox(){
        
        if(boxEmail.text == nil){
            
            let alert = UIAlertController(title: "Forgot", message: "Introduce datos", preferredStyle: .alert)
                
            alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                    
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
