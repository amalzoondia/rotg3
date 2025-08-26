//
//  Login.swift
//  ROTGDemo
//
//  Created by zoondia on 11/08/25.
//

import SwiftUI


struct Login: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let hasError: Bool
    let errorCode: Int
    let message: String
    let response: LoginUserId
}

struct LoginUserId: Codable {
    let uuid: String?
    let user: LoginUser?
    let auth: LoginAuth?
    let userDetails: LoginUserDetail?
}

struct LoginUser : Codable {
    let userId: Int
    let userType: Int
    let name: String
    let email: String
    let profileImage: String
    let designation: String
    let company: String
    let companyLogo: String?
}

struct LoginAuth: Codable {
    let accessToken: String
    let refreshToken: String
    let tokenExpiryTime: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access"
        case refreshToken = "refresh"
        case tokenExpiryTime = "tokenExpiry"
    }
}


struct LoginUserDetail: Codable {
    let notificationUnReadCount: Int
    let pendingActionsCount: Int
}
