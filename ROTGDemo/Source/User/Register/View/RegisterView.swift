import SwiftUI

struct RegisterView: View {
    
    @Binding var isPresented: Bool
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingErrorAlert = false
    @State private var navigateToOtp = false
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollView (.vertical, showsIndicators: false) {
                        ZStack(alignment: .bottomTrailing) {
                            profileImage
                            profileCameraIconImage
                        }
                        registrationForm
                        signIn
                    }
                    
                }
            }
         
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                          }) {
                              Image("backbutton")
                                  .resizable()
                                  .frame(width: 19, height: 15.5)
                                  .padding(.leading, 32)
                          }
                }
                ToolbarItem(placement: .principal) {
                    Text("Register")
                        .font(.custom("Poppins-SemiBold", size: 19.3))
                        .foregroundColor(Color.clrDarkBlueGray2)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
        
    
        var signIn: some View {
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.clrDarkBlueGray)
                    .font(.custom("Poppins-Light", size: 14))
                
                Button {
                       
                    presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isPresented = false
                    }
                } label: {
                        Text("Sign In")
                            .foregroundColor(.clrElectricBlue)
                            .font(.custom("Poppins-Medium", size: 14))
                }
            }
            .padding(.top, 22)
            .padding(.bottom, 156)
        }
        
        var registrationForm: some View {
            VStack {
                VStack {
                    HStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("FULL NAME")
                                        .foregroundColor(.clrBlueGray)
                                        .font(.custom("Poppins-Regular", size: 12))
                                    Spacer()
                                }
                                Spacer()
                                TextField("James Morgan", text: $fullName)
                                    .foregroundColor(.clrDarkIndigo)
                                    .font(.custom("Poppins-Medium", size: 14))
                            }
                        }
                        Spacer()
                    }
                    Divider()
                }
                

      
                    
                
                
                VStack {
                    HStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("EMAIL")
                                        .foregroundColor(.clrBlueGray)
                                        .font(.custom("Poppins-Regular", size: 12))
                                    Spacer()
                                }
                                Spacer()
                                TextField("Jamessavion.com", text: $email)
                                    .foregroundColor(.clrDarkIndigo)
                                    .font(.custom("Poppins-Medium", size: 14))
                            }
                        }
                        Spacer()
                    }
                    Divider()
                }
                .padding(.top, 23)
                VStack {
                    HStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("PASSWORD")
                                        .foregroundColor(.clrBlueGray)
                                        .font(.custom("Poppins-Regular", size: 12))
                                    Spacer()
                                }
                                Spacer()
                                SecureField("", text: $password)
                                    .foregroundColor(.clrDarkIndigo)
                            }
                        }
                        Spacer()
                    }
                    Divider()
                }
                .padding(.top, 31.5)
                VStack {
                    HStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("CONFIRM PASSWORD")
                                        .foregroundColor(.clrBlueGray)
                                        .font(.custom("Poppins-Regular", size: 12))
                                    Spacer()
                                }
                                Spacer()
                                SecureField("", text: $confirmPassword)
                                    .foregroundColor(.clrDarkIndigo)
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.top, 31.5)
                Button {
                    
                    viewModel.validateInputs(fullName: fullName, email: email, password: password, confirmPassword: confirmPassword)
                    if !viewModel.isValid {
                        showingErrorAlert = true
                    }
                    else {
                        viewModel.signUp(fullName: fullName, email: email, password: password) { isSuccess in
                            navigateToOtp = isSuccess
                        }
                    }
                    
                
 
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Medium", size: 16))
                        .frame(width: 291, height: 45)
                        .background(Color.clrElectricBlue)
                        .cornerRadius(30)
                }
                .padding(.top, 37.5)
                .alert(isPresented: $showingErrorAlert) {
                    Alert(title: Text("Message"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                     }
                
                NavigationLink(
                    destination: OtpView(tempUserId: viewModel.tempUserId, email: viewModel.email),
                    isActive: $navigateToOtp
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding(.horizontal, 42)
            .padding(.top, 26.5)
        }
        
        
        var profileImage: some View {
            Image(.profile)
                .resizable()
                .frame(width: 102, height: 102)
                .clipShape(.circle)
        }
        
        
        var profileCameraIconImage: some View {
            Image(.cameraIcon)
                .resizable()
                .frame(width: 28.5, height: 28.5)
        }
    }
    

#Preview {
    RegisterView(isPresented: .constant(true))
}
    
