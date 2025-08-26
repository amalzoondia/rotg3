//
//  OtpView.swift
//  ROTGDemo
//
//  Created by zoondia on 05/08/25.
//

import SwiftUI


struct OtpView: View {

    @StateObject var viewModel: OtpViewModel
    @State private var navigateToLoginView = false
    
    @Environment(\.presentationMode) var presentationMode
    
    init(tempUserId: Int, email: String) {
         _viewModel = StateObject(wrappedValue: OtpViewModel(tempUserId: tempUserId, email: email))
     }
    
    
    var body: some View {
        ZStack {
            Color.white
                  .ignoresSafeArea()
                  .onAppear {
                      print("tempUserId: \(viewModel.tempUserId) - Email: \(viewModel.email)")
                      
                  }
            
  
                ScrollView {
                    
                    otpTextView
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.backbutton)
                                .resizable()
                                .frame(width: 19, height: 15.5)
                                .padding(.leading, 32)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Button(action: {
                            
                        }) {
                            Text("OTP")
                        }
                    }
                }
            
        }
        .navigationBarBackButtonHidden(true)

    }
    
    var otpTextView: some View {
        VStack {

            TextField("OTP", text: $viewModel.otp)
                .padding()
                .frame(width: 283, height: 41)
                .background(Color.clrPaleGray)
                .cornerRadius(30)
            
            HStack {
                Text("Didn’t receive OTP?")
                    .font(.custom("Poppins-Light", size: 13))
                    .foregroundColor(Color.clrDarkIndigoTwo)
                
                Button(action: {
                    viewModel.otpSubmit(){ success in
                           if success {
                               navigateToLoginView = true
                           }
                           else {
                               navigateToLoginView = false
                           }
                       }
                }, label: {
                    Text("Resend Code")
                        .font(.custom("Poppins-SemiBold", size: 13))
                        .foregroundColor(Color.clrDarkIndigoTwo)
                })
            }
            .padding(.top, 19)
            
            Button(action: {
             viewModel.otpSubmit(){ success in
                    if success {
                        navigateToLoginView = true
                    }
                    else {
                        navigateToLoginView = false
                    }
                }
            }, label: {
                Text("Submit")
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(width: 282, height: 45)
                    .background(Color.clrElectricBlue)
                    .cornerRadius(30)
            })
            .padding(.top, 22.5)
            NavigationLink(
                destination: LoginView(),
                isActive: $navigateToLoginView
            ) {
                EmptyView()
            }
//            .hidden()
        }
        .padding(.top, 493)
        
  
    }
}
#Preview {
    OtpView(tempUserId: 1, email: "")
}
