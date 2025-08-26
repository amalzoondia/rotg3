//
//  Otp.swift
//  ROTGDemo
//
//  Created by zoondia on 08/08/25.
//

import Foundation


struct Otp: Codable {
    let tempUserId: Int
    let email: String
    let otp: String
}


struct OtpResponse: Codable {
    let hasError: Bool
    let errorCode: Int
    let message: String
    let response: OtpVerify
}


struct OtpVerify: Codable {
    let otpVerified: Bool
    let uuid: String
    let user: User?
    let auth: Auth?
}


struct User: Codable {
    let userId: Int
    let name: String
    let email: String
    let profileImage: String?
    let designation: String?
    let company: String?
    let companyLogo: String?
}


struct Auth: Codable  {
    let accessToken: String
    let refreshToken: String
    let tokenExpiryTime: Int64
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
        case tokenExpiryTime = "tokenExpiry"
        case time
    }
  }




