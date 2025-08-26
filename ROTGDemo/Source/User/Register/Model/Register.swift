import SwiftUI


struct Register: Codable {
    var uuid: UUID = UUID()
    let name: String
    let email: String
    let profileImage: String
    let password: String
    var designation: String?
    var company: String?
}


struct RegisterResponse: Codable {
    let hasError: Bool
    let errorCode: Int
    let message: String
    let response: TemporaryUserId
}


struct TemporaryUserId: Codable {
    let tempUserId: Int
    let email: String
}



