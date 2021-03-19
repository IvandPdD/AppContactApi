//
//  CrearContactoViewController.swift
//  Whatsapp
//
//  Created by Apps2t on 15/02/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class CrearContactoViewController: UIViewController{
    
    @IBOutlet weak var boxName: UITextField!
        
        
    @IBOutlet weak var boxEmail: UITextField!
    
    
    @IBOutlet weak var boxPhone: UITextField!
        
        
    @IBOutlet weak var buttonSubmit: UIButton!
    
    //logica de crear un contacto
    
    @IBAction func contactsubmit(_ sender: Any){
        
        let activityIndicator = UIActivityIndicatorView() // Create the activity indicator
                view.addSubview(activityIndicator) // add it as a  subview
                activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5) // put in the middle
                activityIndicator.startAnimating() // Start animating
            
        if (boxName == nil || boxEmail == nil || boxPhone == nil ){
                
            alertEmptyBox()
        }else{
            NetworkManager.shared.crearContacto(contact_name: boxName.text!, contact_email: boxEmail.text!, contact_phone: boxPhone.text!,completionHandler: {
                success in
                if success{
                    
                    self.boxName.text = nil
                    self.boxEmail.text = nil
                    self.boxPhone.text = nil
                    
                    activityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "Crear contacto", message: "Contacto creado correctamente", preferredStyle: .alert)
                            
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    activityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "Crear contacto", message: "Ha habido algún erro, prueba otra vez", preferredStyle: .alert)
                            
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
            
            
        
        }
    }
    
    func alertEmptyBox(){
        
        //logica box vacios
                
        if(boxEmail.text == nil){
            
            let alert = UIAlertController(title: "Craer contacto", message: "No has introducido ningun email", preferredStyle: .alert)
                    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
            present(alert, animated: true, completion: nil)
            
        }
        if(boxName.text == nil){
            
            let alert = UIAlertController(title: "Craer contacto", message: "No has introducido ningun nombre", preferredStyle: .alert)
                    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
            present(alert, animated: true, completion: nil)
            
        }
        if(boxPhone.text == nil){
        
            let alert = UIAlertController(title: "Craer contacto", message: "No has introducido ningun telefono", preferredStyle: .alert)
                    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
            present(alert, animated: true, completion: nil)
            
        }
    }
}
