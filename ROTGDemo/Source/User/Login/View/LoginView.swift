import SwiftUI

struct LoginView: View {
    
    
    @State private var email: String = ""
    @State private var passWord: String = ""
    @State private var showFullScreenModal: Bool = false
    @State private var showRegister = false
    @State private var showErrorAlert = false
    @State private var navigateToDashBoard = false
    
    @StateObject private var viewModel = LoginViewModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        logo
                        VStack {
                            emailTextField
                            
                            passwordTextField
                            
                            loginButton
                        }
                        .padding(.top, 36.5)
                        .padding(.horizontal, 46)
                        VStack {
                            forgotPasswordButton
                            
                            registerButton
                            
                            geustUserButton
                        }
                        .padding(.top, 43)
                    }
                }
       
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var geustUserButton: some View {
        Button(action: {
            showFullScreenModal.toggle()
        }) {
            HStack {
                Text("Guest User")
                    .foregroundColor(Color.clrDark)
                    .font(.custom("Poppins-Medium", size: 13))
                    .fontWeight(.medium)
                Image("btnArrow")
            }
            .padding()
            .frame(width: 130, height: 35)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.clrBtnShadow.opacity(0.76), radius: 32.5, x: 0, y: 0 )
        }
        .fullScreenCover(isPresented: $showFullScreenModal) {
            GuestUserView(isPresented: $showFullScreenModal)
        }
        .padding(.top, 34)
        .padding(.bottom, 128)
}
    
     
    var registerButton: some View {
        Button(action: {
            
        }) {
            HStack {
                Text("You don’t have an account?")
                    .foregroundColor(Color.clrDark)
                    .font(.custom("Poppins-Light", size: 14))
                    .fontWeight(.light)
 
                NavigationLink(destination: RegisterView(isPresented: $showRegister)) {
                    Text("Register")
                        .foregroundColor(Color.clrElectricBlue)
                        .font(.custom("Poppins-Medium", size: 14))
                }
            }
        }
        .padding(.top, 16)
    }
    
    
    var forgotPasswordButton: some View {
        Button(action: {
            
        }) {
            Text("Forgot your password?")
                .foregroundColor(Color.clrDarkIndigo)
                .font(.custom("Poppins-Medium", size: 14))
                .fontWeight(.medium)
        }
    }
    
    
    var loginButton: some View {
        VStack {
            Button(action: {
                viewModel.validateInputs(email: email, password: passWord)
                if !viewModel.isValid {
                    showErrorAlert = true
                }
                else {
                    viewModel.LoginVerify(email: email, password: passWord) { success in
                        if success {
                            navigateToDashBoard = true
                        }
                        else {
                            navigateToDashBoard = false
                        }
                    }
                }
                
            }) {
                HStack {
                    Text("Login")
                }
                .foregroundColor(Color.white)
                .font(.custom("Poppins-Medium", size: 16))
                .frame(width: 282.5, height: 45)
                .background(Color.clrElectricBlue)
                .cornerRadius(30)
            }
            .padding(.top, 18.5)
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("\(viewModel.errorMessage)"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink(
                destination: TabbarView(),
                isActive: $navigateToDashBoard
            ) {
                EmptyView()
            }
            .hidden()
        }
    }
        
        
        var passwordTextField: some View {
            HStack {
                Image("passwordIcon")
                
                TextField("Password", text: $passWord)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .padding()
            .background(Color.clrPaleGray)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(.top, 11)
        }
        
        
        var emailTextField: some View {
            HStack {
                Image("emailIcon")
                
                TextField("Email Address", text: $email)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .padding()
            .background(Color.clrPaleGray)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        
        
        var logo: some View {
            VStack {
                Image("logo")
                
                Text("Let’s start with Log in!")
                    .foregroundColor(Color.clrDarkIndigo)
                    .font(.custom("Poppins-Medium", size: 17))
                    .fontWeight(.medium)
                    .padding(.top, 56)
            }
            .padding(.top, 90.5)
            
        }
    }



#Preview {
    LoginView()
}
