//
//  GuestUser.swift
//  ROTGDemo
//
//  Created by zoondia on 04/08/25.
//

import SwiftUI

struct GuestUserView: View {
    @Binding var isPresented: Bool
    
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
               
                    guestUserBgImage
                    
                    guestUserText
                    
                    colorBoxes
                    
                    loginButton
                    
                    registerLink
                    
                    privacyPolicy
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("Image")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .padding(.trailing, 32.5)
                        }
                    }
                }
            }
        }
    }
    
    
    var privacyPolicy: some View {
        
        VStack {
            
            Text("By clicking the button above, you agree to our ")
                .font(.custom("Poppins-Light", size: 12))
                .foregroundColor(Color.clrDarkIndigo) +
            Text("terms of use ")
                .font(.custom("Poppins-Light", size: 12))
                .foregroundColor(Color.clrElectricBlue) +
            Text("and ")
                .foregroundColor(Color.clrDarkIndigo)
                .font(.custom("Poppins-Light", size: 12)) +
            Text("privacy policies.")
                .font(.custom("Poppins-Light", size: 12))
                .foregroundColor(Color.clrElectricBlue)
        }
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 52)
        .padding(.top, 72.5)
        .padding(.bottom, 56.5)
    }
    
    var registerLink: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Text("You don’t have an account?")
                    .foregroundColor(Color.clrDark)
                    .font(.custom("Poppins-Light", size: 14))
                    .fontWeight(.light)
                
                NavigationLink(destination: RegisterView(isPresented: $isPresented)) {
                    Text("Register")
                        .foregroundColor(Color.clrElectricBlue)
                        .font(.custom("Poppins-Medium", size: 14))
                }
            }
        }
        .padding(.top, 19)
    }
    
    
    var loginButton: some View {
        
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Text("Login")
            }
            .padding()
            .foregroundColor(Color.white)
            .font(.custom("Poppins-Medium", size: 16))
            .frame(width: 268, height: 45)
            .background(Color.clrElectricBlue)
            .cornerRadius(30)
        }
        .padding(.top, 25.5)
    }
    
    var guestUserText: some View {
        Text("Guest User")
            .font(.custom("Poppins-SemiBold", size: 20))
            .foregroundColor(Color.clrDarkIndigo)
            .padding(.bottom, 40)
            .padding(.top, 23)
    }
    
    var guestUserBgImage: some View {
        Image("guestUserBgImage")
            .resizable()
            .frame(width: 211, height: 219)
            .padding(.top, 32.5)
    }
    
    var colorBoxes: some View {
        HStack {
            VStack {
                Image(.noteimage)
                 
                Text("Create Observation")
                    .lineLimit(2)
                     .multilineTextAlignment(.center)
                     .padding()
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .padding(.top, 25)
            .frame(width: 128, height: 115)
            .background(Color.clrPink)
            .cornerRadius(20)
            
            VStack {
                Image(.eye)
                    
                Text("View Observation")
                    .lineLimit(2)
                     .multilineTextAlignment(.center)
                     .padding()
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .padding(.top, 25)
            .frame(width: 128, height: 115)
            .background(Color.clrYellow)
            .cornerRadius(20)
            
            .padding(.leading, 12.5)
        }
    }
    
}

//#Preview {
//    GuestUserView()
//}
