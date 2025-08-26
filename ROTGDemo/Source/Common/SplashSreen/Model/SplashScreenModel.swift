import Foundation

struct GenericCheckResponse: Codable {
    let hasError: Bool
    let message: String
    let response: GenericUserDetail 
}

struct GenericUserDetail: Codable {
    let guestDetails: GuestDetails?
    let isGuestUser: Int?
    let message: String?
    let userDetails: String?
    let userId: Int?
    let uuid: String?
}

struct GuestDetails: Codable {
    let company: String?
    let companyLogo: String?
}
