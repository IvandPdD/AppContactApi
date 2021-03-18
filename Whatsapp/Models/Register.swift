// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerUser = try? newJSONDecoder().decode(RegisterUser.self, from: jsonData)

import Foundation

// MARK: - Register
struct Register: Codable {
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let name, email, updatedAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, email
        case updatedAt = "updated_at"
        case id
    }
}
