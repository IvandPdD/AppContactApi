// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contact = try? newJSONDecoder().decode(Contact.self, from: jsonData)

import Foundation

// MARK: - ContactElement
struct ContactElement: Codable {
    let id, userID: Int
    let contactName: String
    let contactPhone: Int
    let contactEmail: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case contactName = "contact_name"
        case contactPhone = "contact_phone"
        case contactEmail = "contact_email"
    }

    public func getName() -> String {
        return self.contactName
    }
    
    public func getPhone() -> Int {
        return self.contactPhone
    }
    
    public func getEmail() -> String {
        return self.contactEmail
    }
}
typealias Contact = [ContactElement]
