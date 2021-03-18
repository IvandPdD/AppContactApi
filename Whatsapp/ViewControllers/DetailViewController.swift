//
//  DetailViewController.swift
//  Whatsapp
//
//  Created by user176708 on 3/7/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var emailLabel: UILabel?
    @IBOutlet weak var phoneLabel: UILabel?
    @IBOutlet weak var contact_name: UITextField?
    @IBOutlet weak var contact_email: UITextField?
    @IBOutlet weak var contact_phone: UITextField?
    
    @IBOutlet weak var delete_button: UIButton?
    
    @IBOutlet weak var modify_button: UIButton?
    
    //logica para cada elemento del table view
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
    //hacemos uso del notification center para bajar el teclado
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let data_name = defaults.string(forKey: "rowName")
        let data_email = defaults.string(forKey: "rowEmail")
        let data_phone = defaults.string(forKey: "rowPhone")
        let id = defaults.string(forKey: "id")
        mainLabel?.text = "Contacto: " + data_name!
        contact_name?.text = data_name!
        contact_email?.text = data_email!
        contact_phone?.text = data_phone!
        
    }
    
    @IBAction override func delete(_ sender: Any?) {
        //logica borrar contacto
        
        let defaults = UserDefaults.standard
        
        let id = defaults.string(forKey: "id")!
        
        let respuesta = NetworkManager.shared.delete(id: id,completionHandler: {
            success in
            if success{
                
                self.performSegue(withIdentifier: "delete", sender: PageViewController.self)
                
            }else {
                
                let alert = UIAlertController(title: "Delete", message: "Algo ha fallado", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
                
            }
        })
        
         
        
    }
    
    @IBAction func modify(_ sender: Any?){
        //logica modificar contacto
        let defaults = UserDefaults.standard
        
        let id = defaults.string(forKey: "id")!
        
        NetworkManager.shared.modify(id: id, contact_name: (contact_name?.text)!, contact_email: (contact_email?.text)!, contact_phone: (contact_phone?.text)!,completionHandler: {
            success in
            if success{
                self.performSegue(withIdentifier: "modify", sender: PageViewController.self)
            }else{
                
                let alert = UIAlertController(title: "Modificar", message: "Algo ha fallado", preferredStyle: .alert)
                    
                alert.addAction(UIAlertAction(title: "Fail", style: .default, handler: nil))
                        
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
