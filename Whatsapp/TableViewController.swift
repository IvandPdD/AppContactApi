//
//  Collection ViewController.swift
//  Whatsapp
//
//  Created by Apps2t on 15/02/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var names: [ContactElement] = []
    @IBOutlet weak var tableView: UITableView!

    
    override func viewWillAppear(_ animated: Bool) {
        //recargar tabla cada vez para mantener datos actualizados
        getJson()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getJson()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //logica seleccion de celda
        let defaults = UserDefaults.standard
        let data_name = self.names[indexPath.row].contactName
        let data_phone = self.names[indexPath.row].contactPhone
        let data_email = self.names[indexPath.row].contactEmail
        let id = self.names[indexPath.row].id
        defaults.setValue(data_name, forKey: "rowName")
        defaults.setValue(data_email, forKey: "rowEmail")
        defaults.setValue(data_phone, forKey: "rowPhone")
        defaults.setValue(id, forKey: "id")

        self.performSegue(withIdentifier: "showContact", sender: DetailViewController.self)
        print(self.names[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //devolvemos numero de filas
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //declaramos celdas
        
        let cell : StaffTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StaffTableViewCell
        let contact = names[indexPath.row]
        cell.labelName.text = contact.getName()
        cell.labelEmail.text  = contact.getEmail()
        cell.labelPhone.text = String(contact.getPhone())
        
        return cell
    }
    
    func getJson(){
            
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/showContact")!
            
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
            
            //se le indica el protocolo con el que se envia
            request.httpMethod = "GET"
        
            let defaults = UserDefaults.standard
            let data = defaults.string(forKey: "token")
        
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + data!]
            
            //se envia la peticion usando alamofire
        AF.request(request).validate().responseDecodable(of: [ContactElement].self)
            { response in
            guard let contactResponse = response.value else {return}
            debugPrint(contactResponse)
            print("Tabla")
            
            self.names = contactResponse
                
                if(response.error == nil){
                    //bucle for para iterr elementos
                    for contactName in contactResponse{
                        
                        for i in 0..<contactResponse.count{
                            //los introducimos enla tabla
                        self.names.append(contactResponse[i])
                        self.tableView.reloadData()
                            
                        }
                    }
                    if(contactResponse.isEmpty){
                        let alert = UIAlertController(title: "Contactos", message: "DNo hay contactos que mostrar", preferredStyle: .alert)
                            
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                        self.present(alert, animated: true, completion: nil)

                    }
                    
                    
                }else{
                    
                    let alert = UIAlertController(title: "Contacts", message: "Ha habido un error", preferredStyle: .alert)
                        
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        
        }
    
    
 }
