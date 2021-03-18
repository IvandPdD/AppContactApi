//
//  NetworkManager.swift
//  Whatsapp
//
//  Created by user176708 on 3/5/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    
    
    //variables necesarias para la realizacion de peticiones
    var result = ""
    var resultContact = ""
    
    //variable estatica para llamar a las request
    static var shared:NetworkManager = NetworkManager()
    static var respuesta = ""
    static var respuestaContacto = ""
    var token = ""
    
    //funcion de registrar
    func register(name: String, email: String, password: String, password_confirmation: String,completionHandler: @escaping(Bool)->Void ){
            
            struct Register: Encodable {
                
                let name: String
                let email: String
                let password: String
                let password_confirmation: String
            }
            
            //alamcenamos la URL de la api
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/register")!
            
            //preparamos las variables a enviar
            let register: [String:Any] = ["name": name, "email": email, "password": password, "password_confirmation": password_confirmation]
            
            print(register)
            
            //las transformamos en JSON
            let registerJson = try? JSONSerialization.data(withJSONObject: register)
            
            //llamamos a la request junto a la URL
            var request = URLRequest(url: url)
            
            //indicamos el protocolo
            request.httpMethod = "POST"
            
            // contenido del body
            request.httpBody = registerJson
            
            //le introducimos los headers necesarios
            request.headers = ["Content-Type": "application/json"]
            
            //se envia la peticion usando alamofire
            //utilizamos el completion handler para sincronizar peticiones
            AF.request(request).response  { response in
                guard let registerResponse = response.value else {return}
                
                debugPrint(response.value)
                
                let defaults = UserDefaults.standard
                
                if(response.error == nil){
                    completionHandler(true)
                }else {
                    completionHandler(false)
                }
            }
            
        }
    
    func login(email: String, password: String,completionHandler: @escaping(Bool)->Void ){
        
        struct Login: Encodable {
                    
                    let email: String
                    let password: String
                }
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/login")!
                
        //preparamos las variables a enviar
        let login: [String:Any] = ["email": email , "password": password]
                
        print(login)
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: login,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json"]
                
        //se envia la peticion usando alamofire
        AF.request(request).responseJSON()
            { response in
            
            debugPrint(response)
            
            if(response.error == nil){
                
                do{
                let user = try JSONDecoder().decode(LoginUser.self , from: response.data!)
                    
                    debugPrint(user.token)
                    
                    self.token = user.token
                    
                    let defaults = UserDefaults.standard
                    
                    defaults.set(user.token, forKey: "token")
                    
                
                completionHandler(true)
                    
                }catch{
                    
                }
                
            }else{
                completionHandler(false)
            }
        }
    }
    
    func crearContacto(contact_name: String, contact_email: String, contact_phone: String,completionHandler: @escaping(Bool)->Void){
            
            struct Contact: Encodable {
                
                let contact_name: String
                let contact_email: String
                let contact_phone: String
            }
            
            //alamcenamos la URL de la api en una varianle
            let url = URL(string: "https://conctactappservice.herokuapp.com/api/create")!
            
            //preparamos las variables a enviar
            let contact: [String:Any] = ["contact_name": contact_name, "contact_email": contact_email, "contact_phone": contact_phone]
            
            print(register)
            
            //las transformamos en JSON
            let jsonContact = try? JSONSerialization.data(
            withJSONObject: contact)
            
            //llamamos a la request, dandole la url
            var request = URLRequest(url: url)
            
            //se le indica el protocolo con el que se envia
            request.httpMethod = "POST"
            
            //se le indica el contenido del body
            request.httpBody = jsonContact
        
            let defaults = UserDefaults.standard
            let data = defaults.object(forKey: "token")
        
            //el header
            request.headers = ["Content-Type": "application/json",
                               "Authorization":"Bearer" + token]
            
            //se envia la peticion usando alamofire
            AF.request(request).validate().responseJSON  { response in
                
            debugPrint(response)
                
                if(response.error == nil){
                    
                    completionHandler(true)
                    
                }else{
                    
                    completionHandler(false)
                    
                }
            }
        }
    
    
    func delete(id: String,completionHandler: @escaping(Bool)->Void){
        
        struct Delete: Encodable {
                    
                    let id: String
                }
        
        let string_id = String(id)
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/eraseContact")!
                
        //preparamos las variables a enviar
        let login: [String:Any] = ["id": id]
                
        print(login)
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: login,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + self.token]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().responseJSON()
            { response in
            
            debugPrint(response)
            
            let defaults = UserDefaults.standard
            
            if(response.error == nil){
                
               completionHandler(true)
                
            }else {
                
                completionHandler(false)
                
            }
        }
    }
    
    func deleteUser(id: String,completionHandler: @escaping(Bool)->Void){
        
        struct Delete: Encodable {
                    
                    let id: String
                }
        
        let string_id = String(id)
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/eraseUser")!
                
        //preparamos las variables a enviar
        let login: [String:Any] = ["id": id]
                
        print(login)
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: login,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + self.token]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().responseJSON()
            { response in
            
            debugPrint(response)
            
            let defaults = UserDefaults.standard
            
            if(response.error == nil){
                
               completionHandler(true)
                
            }else {
                
                completionHandler(false)
                
            }
        }
    }
    
    func forgot(email: String,completionHandler: @escaping(Bool)->Void){
        
        struct forgot: Encodable {
                    
                    let email: String
                }
        
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/password/email")!
                
        //preparamos las variables a enviar
        let contact: [String:Any] = [ "email": email]
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: contact,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json"]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().responseJSON()
            { response in
            
            debugPrint(response)
            
            let defaults = UserDefaults.standard
            
            if(response.error == nil){
                
                completionHandler(true)
                
            }else {
                
                completionHandler(false)
                
            }
        }
    }
    
    func modify(id: String,contact_name: String, contact_email: String, contact_phone: String,completionHandler: @escaping(Bool)->Void){
        
        struct Modify: Encodable {
                    
                    let id: String
                    let contact_name: String
                    let contact_email: String
                    let contact_phone: String
                }
        
        let string_id = String(id)
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/updateContact/" + string_id)!
                
        //preparamos las variables a enviar
        let contact: [String:Any] = ["contact_name": contact_name, "contact_email": contact_email, "contact_phone": contact_phone]
                
        print(login)
                
        //las transformamos en JSON
        let jsonLogin = try? JSONSerialization.data(
            withJSONObject: contact,
            options: [])
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "POST"
                
        //se le indica el contenido del body
        request.httpBody = jsonLogin
                
        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + self.token]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().responseJSON()
            { response in
            
            debugPrint(response)
            
            let defaults = UserDefaults.standard
            
            if(response.error == nil){
                
                completionHandler(true)
                
            }else {
                
                completionHandler(false)
                
            }
        }
    }
    
    func getUser(completionHandler: @escaping(UserDTO?)->Void){
        
                
        //alamcenamos la URL de la api en una varianle
        let url = URL(string: "https://conctactappservice.herokuapp.com/api/user")!
                
        //llamamos a la request, dandole la url
        var request = URLRequest(url: url)
                
        //se le indica el protocolo con el que se envia
        request.httpMethod = "GET"
                
        //el header
        request.headers = ["Content-Type": "application/json",
                           "Authorization":"Bearer" + self.token]
                
        //se envia la peticion usando alamofire
        AF.request(request).validate().responseJSON()
        { response in
            
            debugPrint(response)
            
            let defaults = UserDefaults.standard
            
            if(response.error == nil){
                do{
                let user = try JSONDecoder().decode(UserDTO.self , from: response.data!)
                
                completionHandler(user)
                    
                }catch{
                    
                }
            }else {
                
                completionHandler(nil)
                
            }
        }
    }
}
